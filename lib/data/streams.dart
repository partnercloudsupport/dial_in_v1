import 'dart:async';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


/// Making Profiles in Bloc in the Way of technical debt :)
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

  void add(Profile profile){}

  Future getProfiles({Profile profile})async{

    if(!_initilised){
    _initilised = true;
    _incomingController = _incomingController = StreamController<QuerySnapshot>.broadcast();
    _outgoingController = BehaviorSubject<List<Profile>>();

    String userID = await DatabaseFunctions.getCurrentUserId();
    _incomingController.addStream
    (DatabaseFunctions.getStreamFromFireStore(_databaseId, DatabaseIds.user, userID));

    _incomingController.stream.listen((p){
      DatabaseFunctions.convertStreamToListOfProfiles(p,_databaseId)
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

  Stream<List<FeedProfileData>> get profiles => _outgoingController.stream;

  var _outgoingController = BehaviorSubject<List<FeedProfileData>>();
  var _incomingController = StreamController<QuerySnapshot>.broadcast();

  /// Init of the class
  SocialFeedBloc(this._databaseId, this._currentUserStream, {this.isUserFollowing} )
  {_currentUserStream.listen((profile){
    _currentUser = profile;
    getProfiles();
    
   });
  }

  void deinit(){
    _initilised = false;
  }

  void refresh(){
   _initilised = false;
    getProfiles();
  }

  Future getProfiles()async{
  
   if(!_initilised){

    _initilised = true;
    if(_databaseId == DatabaseIds.community)
    {_incomingController.addStream
                        (DatabaseFunctions.getStreamFromFireStore(DatabaseIds.recipe, DatabaseIds.public, true));
    
    }else
    {_incomingController.addStream( 
                        DatabaseFunctions.getStreamFromFireStore(DatabaseIds.recipe, DatabaseIds.public, true));
      }

    _incomingController.stream.listen((p){


      /// Process for sorting community profiles
      if(_databaseId == DatabaseIds.community){
        DatabaseFunctions.convertStreamToListOfProfiles(p, DatabaseIds.recipe)
        .then((profilesOut){ 

          var profiles = _returnListOfProfilesWithoutUserProfiles(profilesOut);

          convertProfilesToListOfFeedProfiles(profiles).then(

          (feedProfiles){_outgoingController.add(feedProfiles);}
          );
        });

      /// For following only
      }else{      
         DatabaseFunctions.convertStreamToListOfProfiles(p, DatabaseIds.recipe)
        .then((profilesOut){ 

          var profiles = _returnListOfProfilesWithoutUserProfiles(profilesOut);

          /// remove none followers
          profiles.removeWhere((profile)  
          {if (profile.userId != null){
            if(!isUserFollowing(profile.userId)){ return true;}};

          convertProfilesToListOfFeedProfiles(profiles)
          
          .then((List<FeedProfileData> feedListProfiles){ 

            
              _outgoingController.add(feedListProfiles);}
          );
        }
        );
        }
        );
      }
    }
  );
  }
  }

  List<Profile> _returnListOfProfilesWithoutUserProfiles(List<Profile> profilesIn){

    var profiles = new List<Profile>.from(profilesIn);
              /// Remove Current User profiles
                profiles.removeWhere((profile) { 
                   
                if (profile.userId != null){

                  String otherUserId = profile.userId;
                  String currentUserId = _currentUser.userId;
                    
                    /// Remove the profile where the profile userId is eqaula to the currrent userId
                    if (otherUserId == currentUserId){ 
                      return true;}
                    else{ return false;}
    
              }});
    return profiles ?? NullThrownError();
  }


  Future<List<FeedProfileData>>convertProfilesToListOfFeedProfiles(List<Profile> stream) async {
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
  UserProfile _userProfile;

  String get userImage => _userProfile.userImage;
  String get userId => _userProfile.userId;
  String get userName => _userProfile.userName;
  List <String> get following => _userProfile.following;

  Stream<UserProfile> get userProfile => _outgoingController.stream;
  
  final BehaviorSubject<UserProfile> _outgoingController = BehaviorSubject<UserProfile>();

  void deinit(){
    _initilised = false;
  }

  void refresh(){
    _initilised = false;
    getProfile();
  }

  Future getProfile()async{
  
   if(!_initilised){

     _initilised= true;

      DatabaseFunctions.getCurrentUserId()
      .then((user)
      {DatabaseFunctions.getUserProfileFromFireStoreWithDocRef(user)

        .then((userProfile)
          
        {_userProfile = userProfile;
         _outgoingController.add(_userProfile);});

      }).catchError((e) => print(e));
   }
  }
}