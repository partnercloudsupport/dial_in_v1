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

  final _outgoingController = BehaviorSubject<List<Profile>>();
  final _incomingController = StreamController<QuerySnapshot>.broadcast();

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
    _outgoingController.drain();
    _incomingController.close();
  }

  void add(Profile profile){}

  Future getProfiles({Profile profile})async{

    if(!_initilised){
    _initilised = true;
    String userID = await DatabaseFunctions.getCurrentUserId();

    _incomingController.addStream
    (Firestore.instance.collection(_databaseId)
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


  final _outgoingController = BehaviorSubject<List<FeedProfileData>>();
  Stream<List<FeedProfileData>> get profiles => _outgoingController.stream;

  final _incomingController = StreamController<QuerySnapshot>.broadcast();

  /// Init of the class
  SocialFeedBloc(this._databaseId);

  void deinit(){
    _initilised = false;
    _outgoingController.drain();
    _incomingController.close();
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
      DatabaseFunctions.convertStreamToListOfProfiles(p, DatabaseIds.recipe)
      .then((profiles){ 

        convertProfilesToListOfFeedProfiles(profiles).then(

        (feedProfiles){_outgoingController.add(feedProfiles);}
        );
      }
      );
    }
    );
   }
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
    _outgoingController.drain();
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