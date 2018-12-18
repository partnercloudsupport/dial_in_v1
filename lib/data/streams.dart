import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'dart:io';

/// Making Profiles in Bloc in the Way of technical debt :)
class FeedBloc{

  ///Other Variables
  final String _databaseId;
  String get databaseId => _databaseId;
  bool initilised = false;


  final _outgoingController = BehaviorSubject<List<Profile>>();
  final _incomingController = StreamController<QuerySnapshot>.broadcast();

  
  Stream<List<Profile>> get profiles => _outgoingController.stream;
    
  
  /// Init of the class
  FeedBloc(this._databaseId){
   
   _getProfiles();
    
  }

  Future _getProfiles({Profile profile})async{

    if(!initilised){
    initilised = true;
    String userID = await DatabaseFunctions.getCurrentUserId();

    _incomingController.addStream(Firestore.instance.collection(_databaseId)
    .where(DatabaseIds.user, isEqualTo: userID).snapshots());

    _incomingController.stream.listen((p){
      convertStreamToListOfProfiles(p)
      .then((profiles){ 

        if (profile != null){profiles.add(profile);}
        _outgoingController.add(profiles);});
      }
    );
    }
  }


  Future<List<Profile>> convertStreamToListOfProfiles(QuerySnapshot stream) async {

    final futureProfiles = stream.documents.map((doc) => 
        DatabaseFunctions.createProfileFromDocumentSnapshot(_databaseId, doc));
           
    return await Future.wait(futureProfiles);
  }


  void add(Profile profile){
    // _getProfiles(profile: profile);
  }
}  

/// Social card

class SocialFeedBloc{

  ///Other Variables
  final String _databaseId;
  String get databaseId => _databaseId;


  final _outgoingController = BehaviorSubject<List<FeedProfileData>>();
  Stream<List<FeedProfileData>> get profiles => _outgoingController.stream;

  var _profiles = <FeedProfileData>[];

  /// Init of the class
  SocialFeedBloc(this._databaseId){
    _getProfiles().then((_){
      _outgoingController.add(_profiles);
    });
  }

  Future _getProfiles()async{
  
    if(_databaseId == DatabaseIds.community)
    {await convertStreamToListOfProfiles(Firestore.instance.collection(DatabaseIds.recipe)
    .where(DatabaseIds.public, isEqualTo: true).snapshots());}

    else
    {await convertStreamToListOfProfiles(Firestore.instance.collection(DatabaseIds.recipe)
    .where(DatabaseIds.public, isEqualTo: true).snapshots());}

    return;
  }

  Future convertStreamToListOfProfiles(Stream<QuerySnapshot> stream) async {
    List<Profile> profiles;
    await for (var value in stream) {

      final futureProfiles = value.documents.map((doc) => 
          DatabaseFunctions.createProfileFromDocumentSnapshot(_databaseId, doc));

      profiles = await Future.wait(futureProfiles);
      await convertProfilesToListOfFeedProfiles(profiles);
      return;
    }
  }

    Future convertProfilesToListOfFeedProfiles(List<Profile> stream) async {
      
      for(var doc in stream){  /// <<<<==== changed line
              FeedProfileData result = await Functions.createFeedProfileFromProfile(doc);
              _profiles.add(result);
      }
      return;
    }

}

//  class FeedBloc{

//     ///Other Variables
//     final String _databaseId;
//     String get databaseId => _databaseId;

//     final _outgoingController = BehaviorSubject<List<Profile>>();
    
//     Stream<List<Profile>> get profiles => _outgoingController.stream;
    
//     List<Profile> _profiles = new List<Profile>();

//     void add(Profile profile){
//       _profiles.add(profile);
//       _outgoingController.add(_profiles);
//     }

//     /// Init of the class
//     FeedBloc(this._databaseId){
      
//       _getProfiles().then((_){
//         _outgoingController.add(_profiles);
//       });
//     }

//     Future _getProfiles()async{

//       String userID = await DatabaseFunctions.getCurrentUserId();

//       await convertStreamToListOfProfiles(Firestore.instance.collection(_databaseId)
//       .where(DatabaseIds.user, isEqualTo: userID).snapshots());
      
//       return;
//     }

    // Future convertStreamToListOfProfiles(Stream<QuerySnapshot> stream) async {
    //   List<Profile> profiles;

    //   await for (var value in stream) {

    //     final futureProfiles = value.documents.map((doc) => 
    //         DatabaseFunctions.createProfileFromDocumentSnapshot(_databaseId, doc));

    //     profiles = await Future.wait(futureProfiles);
    //     _profiles = profiles;
    //     return;
    //   }
    // }
//   }