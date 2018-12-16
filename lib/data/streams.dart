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

  final _outgoingController = BehaviorSubject<List<Profile>>();
  
  Stream<List<Profile>> get profiles => _outgoingController.stream;
  
  var _profiles = <Profile>[];

  /// Init of the class
  FeedBloc(this._databaseId){
    
    _getProfiles().then((_){
      _outgoingController.add(_profiles);
    });
  }

  Future _getProfiles()async{

    String userID = await DatabaseFunctions.getCurrentUserId();

    await convertStreamToListOfProfiles(Firestore.instance.collection(_databaseId)
    .where(DatabaseIds.user, isEqualTo: userID).snapshots());
    
    /// TODO .where(DatabaseIds.user, isEqualTo: DßatabaseFunctions.getCurrentUserId())
    return;
  }

  Future convertStreamToListOfProfiles(Stream<QuerySnapshot> stream) async {
    List<Profile> profiles;

    await for (var value in stream) {

      final futureProfiles = value.documents.map((doc) => 
          DatabaseFunctions.createProfileFromDocumentSnapshot(_databaseId, doc));

      profiles = await Future.wait(futureProfiles);
      _profiles = profiles;
      return;
    }
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