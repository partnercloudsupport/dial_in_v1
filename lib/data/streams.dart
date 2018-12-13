import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../data/profile.dart';
import '../data/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dial_in_v1/database_functions.dart';



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
    
    await convertStreamToListOfProfiles(Firestore.instance.collection(_databaseId).snapshots());
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


// /// Making Profiles in Bloc in the Way of technical debt :)
// class FeedBloc{

//   ///Other Variables
//   final String _databaseId;
//   String get databaseId => _databaseId;

//   Stream<QuerySnapshot> _incomingStream;
//   StreamController<QuerySnapshot> _incomingController = StreamController.broadcast();


//   final _outgoingController = BehaviorSubject<List<Profile>>();
  
//   Stream<List<Profile>> get profiles => _outgoingController.stream;
  
//   var _profiles = <Profile>[];

//   /// Init of the class
//   FeedBloc(this._databaseId){
//     _incomingStream = Stream.castFrom(Firestore.instance.collection(_databaseId).snapshots());

//     _incomingStream.pipe(_incomingController);

//     _incomingStream.listen((newData) { 
//       _incomingController.sink.add(newData);
//       print('Incoming $newData');});
 
//     _updateProfiles().then((_){
//       _outgoingController.add(_profiles);
//     });
//   }

//   Future _updateProfiles()async{
    
//     await sumStream(_incomingStream);
//   }

//   Future sumStream(Stream<QuerySnapshot> stream) async {
//     List<Profile> profiles;
//     await for (var value in stream) {

//       final futureProfiles = value.documents.map((doc) => 
//           DatabaseFunctions.createProfileFromDocumentSnapshot(_databaseId, doc));

//       profiles = await Future.wait(futureProfiles);
//       _profiles = profiles;
//     }
//   }
// }




// /// Making Profiles in Bloc
// class FeedBloc{

//   ///Other Variables
//   final String _databaseId;

//   // Stream<List<Profile>> get profiles => _streamController.stream;

//   var profiles = <Profile>[];
//   final _outgoingController = BehaviorSubject<List<Profile>>();

//   Stream<QuerySnapshot> _data;
//   Stream get data => _data;

//   StreamController _streamController;
//   StreamController get streamController => _streamController;


//   /// Init of the class
//   FeedBloc(this._databaseId){

//     _streamController = StreamController.broadcast();
//     _streamController.stream.listen((item){ _streamController.add(item);});

//     _data = Firestore.instance.collection(_databaseId).snapshots();

//     _data.map((map) => DatabaseFunctions.createProfileFromDocumentSnapshot(_databaseId ,map));
//     _data.pipe(_streamController);
//   }

//   Future<Profile> getProfile()
// }

// class FeedBloc{

//   ///Other Variables
//   final String _databaseId;
//   List<Profile> _profiles;

//   Stream incomingProfiles; 

//   //  ///Incoming Data from firebase
//   // Sink<DocumentSnapshot> get addition => _streamController.sink;

//   /// Return a Stream list
//   Stream<List<Profile>> get profiles => _outgoingController.stream; 
  
 
  
//   ///Controller of the data
//   StreamController _streamController;

//   /// Saves the last value - Same as a stream controller but better
//   final _outgoingController = BehaviorSubject<List<Profile>>();

//   /// Init of the class
//   FeedBloc(this._databaseId){
//     _streamController = StreamController.broadcast();

//     incomingProfiles =  Firestore.instance.collection(_databaseId).snapshots().asBroadcastStream();
    
//     _streamController.addStream(incomingProfiles);
//     // _streamController.addStream(incomingProfiles.);
//     /// Link the function to the controller that converts the input, to the output of the stream
//   }
  

//   Future<void> _updateProfiles(DocumentSnapshot document)async{
    
//     Profile _profile = await DatabaseFunctions.createProfileFromDocumentSnapshot(_databaseId ,document);

//     _profiles.add(_profile);
//     _outgoingController.add(_profiles);
//   }
// }

//  class FeedBloc{

// //   ///Other Variables
//   final String databaseId;
//   final Function(Profile) giveprofile;

//   /// List of widgets to be returned
//   final  List<Widget> _list = List<Widget>(); 
  
//   ///Incoming Data from firebase
//   Sink<DocumentSnapshot> get addition => _streamController.sink;
  
//   ///Controller of the data
//   final _streamController = StreamController<DocumentSnapshot>();

//   /// Saves the last value
//   final _outgoingController = BehaviorSubject<Widget>();

//   ///Stream
//   Stream<Widget> get list => _outgoingController.stream;

//   /// Init of the class
//   FeedBloc(this.databaseId, this.giveprofile){
//     /// Link the function to the controller that converts the input, to the output of the stream
//     _streamController.stream.listen(_handle);
//   }

//   void _handle(DocumentSnapshot document)async{
    
//     Widget card = await Functions.buildProfileCardFromDocument(document, databaseId, giveprofile);

//     _list.add(card);
//     _outgoingController.add(card);
//   }
// }

/// Making cards in Bloc

// class FeedBloc{

//   ///Other Variables
//   final String databaseId;
//   final Function(Profile) giveprofile;

//   /// Return a Stream list
//   Stream<List<Widget>> get list => _outgoingController.stream; 
  
//   ///Incoming Data from firebase
//   Sink<DocumentSnapshot> get addition => _streamController.sink;
  
//   ///Controller of the data
//   final _streamController = StreamController<DocumentSnapshot>();

//   /// Saves the last value
//   final _outgoingController = BehaviorSubject<List<Widget>>();

//   /// Init of the class
//   FeedBloc(this.databaseId, this.giveprofile){
//     /// Link the function to the controller that converts the input, to the output of the stream
//     _streamController.stream.listen(_handle);
//   }

//   void _handle(DocumentSnapshot document)async{
    
//     Widget card = await Functions.buildProfileCardFromDocument(document, databaseId, giveprofile);

//     DatabaseFunctions.createProfileFromDocumentSnapshot
//     _list.add(card);
//     _outgoingController.add(card);
//   }
//