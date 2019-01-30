import 'dart:async';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FeedBloc{

  ///Other Variables
  final String _databaseId;
  String get databaseId => _databaseId;
  bool _initilised = false;

  var _outgoingController = BehaviorSubject<List<Profile>>();
  var _incomingController = StreamController<QuerySnapshot>.broadcast(sync: false);

  void removeProfile(Profile profile){
    _profiles.removeWhere((p) => p.objectId == profile.objectId);
      _outgoingController.add(_profiles);
  }

  Stream<List<Profile>> get profiles => _outgoingController.stream;
    
  List<Profile> _profiles;
  int get profilesCount => _profiles.length;

  /// Init of the class
  FeedBloc(this._databaseId);

  /// Deinit
  void deinit(){
    _initilised = false;
  }

  void dispose() { 
    _outgoingController.close();
    _incomingController.close();
  }

  void add(Profile profile){}

  Future getProfiles({Profile profile})async{

    if(!_initilised){
    _initilised = true;
    _incomingController = _incomingController = StreamController<QuerySnapshot>.broadcast();
    _outgoingController = BehaviorSubject<List<Profile>>();

    String userID = await Dbf.getCurrentUserId();
    _incomingController.addStream
    (Dbf.getStreamFromFireStore(_databaseId, DatabaseIds.user, userID));

    _incomingController.stream.listen((p){
      Dbf.convertStreamToListOfProfiles(p,_databaseId)
      .then((profiles){ 
        _profiles = profiles;
        if (profile != null){profiles.add(profile);}
        _outgoingController.add(profiles);}
        );
      }
    );
    }
  }
}  

/// Social card

class SocialFeedBloc{

  ///Other Variables
  final String _databaseId;
  String get databaseId => _databaseId;
  bool _initilised = false;
  Stream<UserProfile> _currentUserStream;
  UserProfile _currentUser;
  Function(String) isUserFollowing;
  List<Profile> _currentFeedData;
  

  Stream<List<FeedProfileData>> get profiles => _outgoingController.stream;

  var _outgoingController = BehaviorSubject<List<FeedProfileData>>();
  var _incomingController = StreamController<QuerySnapshot>.broadcast();

  /// Init of the class
  SocialFeedBloc(this._databaseId, this._currentUserStream, {this.isUserFollowing} )
  {_currentUserStream.listen((user){
    assert(user != null , 'user is null');
    _currentUser = user;
    _userStreamListenerFunction();
   });
  }

  void deinit(){
    _initilised = false;
  }
  
  void dispose() { 
    _outgoingController.close();
    _incomingController.close();
  }

  Future getProfiles()async{
  
    if(!_initilised){

      _initilised = true;
    
      _incomingController.addStream( 
                          Dbf.getStreamFromFireStore(DatabaseIds.recipe, DatabaseIds.public, true));
        
      _incomingController.stream.listen(_profileStreamListenerFunction);
    }
  }

  void _userStreamListenerFunction(){
    
    if(_currentFeedData != null){
    handleProfileList(_currentFeedData);}
    else{
      if(_initilised){ print('_currentFeedData is null');}
    }
  }

  void _profileStreamListenerFunction(QuerySnapshot p){

     Dbf.convertStreamToListOfProfiles(p, DatabaseIds.recipe)
        .then((profilesOut){

          handleProfileList(profilesOut);
      }
    ); 
  }

  void handleProfileList(List<Profile> profilesin){
    
      _currentFeedData = profilesin;

      var profiles = _returnListOfProfilesWithoutUserProfiles(profilesin);

     if(_databaseId == DatabaseIds.community){


          convertProfilesToListOfFeedProfiles(profiles).then(

          (feedProfiles){_outgoingController.add(feedProfiles);
          
        });

      /// For following only
      }else{      
        

          /// remove none followers
          profiles.removeWhere((profile) 

          {if (profile.userId != null){

             bool result;

              if (_currentUser.following != null) {

              List<String> followingList = _currentUser.following;

               result =  followingList.contains(profile.userId); 
              }    

              bool returnValue = !result;

              return returnValue;

          }});

          convertProfilesToListOfFeedProfiles(profiles)
          
          .then((List<FeedProfileData> feedListProfiles){ 
            
              _outgoingController.add(feedListProfiles);}
          );
        }
  }

  List<Profile> _returnListOfProfilesWithoutUserProfiles(List<Profile> profilesIn){

    var profiles = new List<Profile>.from(profilesIn);
              /// Remove Current User profiles
                profiles.removeWhere((profile) { 
                   
                if (profile.userId != null){

                  assert(_currentUser.id != null, 'user D is null');

                  String otherUserId = profile.userId ?? '';
                  String currentUserId = _currentUser.id ?? '';
                    
                    /// Remove the profile where the profile userId is eqaula to the currrent userId
                    if (otherUserId == currentUserId){ 
                      return true;}
                    else{ return false;}
    
              }});
    return profiles ?? NullThrownError();
  }


  Future<List<FeedProfileData>> convertProfilesToListOfFeedProfiles(List<Profile> stream) async {
      List<FeedProfileData> profiles = new List<FeedProfileData>();

      for(var doc in stream){  /// <<<<==== changed line
              FeedProfileData result = await Functions.createFeedProfileFromProfile(doc);
              profiles.add(result);
      }
      return profiles;
      // return wait Future.wait(profiles)
    }
}

class UserFeed {
   
  bool _initilised = false;
  Stream<UserProfile> get userStream{assert(_outgoingController.stream != null, '_userDetails is null'); return _outgoingController.stream;}

  CurrentUserDetailsStream currentUserDetailsStream = CurrentUserDetailsStream();
  UserDetails _userDetails;
  UserDetails get userDetails {assert(_userDetails != null, '_userDetails is null'); return _userDetails;}

  CurrentUserProfileStream currentUserProfileStream;
  UserProfile _userProfile;
  UserProfile get userProfile {assert(_userProfile != null, '_userProfile is null'); return _userProfile;}
  
  final BehaviorSubject<UserProfile> _outgoingController = BehaviorSubject<UserProfile>();
  final BehaviorSubject<UserDetails> _outgoingUserDetailsController = BehaviorSubject<UserDetails>();


  UserFeed(){

    currentUserProfileStream = CurrentUserProfileStream(
                              currentUserDetailsStream
                              .userDetailsStreamcontroller
                              .stream);

    ///Make user Profile streams from firebase :)
     Dbf.getCurrentUserStream();
  }

  void deinit(){
    _initilised = false;
  }

  void dispose() { 
    _outgoingController.close();
    _outgoingUserDetailsController.close();
  }

  void refresh(){
    _initilised = false;
    getProfile();
  }

  Future getProfile()async{
  
   if(!_initilised){

     _initilised= true;

      _userDetails = await Dbf.getCurrentUserDetails()
                        .catchError((error)=> print(error));

      _outgoingUserDetailsController.add(_userDetails);

      Dbf.getUserProfileFromFireStoreWithDocRef(_userDetails.id)
        .then((userProfile){
              _userDetails.userName = userProfile.userName; 
              _userDetails.photoUrl = userProfile.imageUrl;
              // _userDetails.imagePath = userProfile.imageFilePath;
              _userDetails.motto = userProfile.motto; 
              _userProfile = userProfile;
         _outgoingController.add(_userProfile);
         _outgoingUserDetailsController.add(_userDetails);}).catchError((e) => print(e));
      }
   }
}
