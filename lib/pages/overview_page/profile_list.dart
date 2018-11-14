import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/strings.dart';
import '../../widgets/custom_widgets.dart';
import '../../data/profile.dart';
import '../../data/item.dart';
import '../../database_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/functions.dart';

class ProfileList extends StatefulWidget{

 final String _listDatabaseId = 'Barista';

 _ProfileListState createState() => new _ProfileListState();
}


class _ProfileListState extends State<ProfileList>{

    List<Profile> _profiles;

    @override
    initState(){

    

    super.initState();
 }


Widget _buildProfileCard(BuildContext context, DocumentSnapshot document, String databaseId){

  List<Item> _properties = new List<Item>();
  document.data.forEach((key, value) {

      if ( key != DatabaseFunctions.updatedAt){

      if ( key != DatabaseFunctions.objectId) {

      if ( key != DatabaseFunctions.databaseId){

      if ( key != DatabaseFunctions.databaseId){

      if ( key != DatabaseFunctions.orderNumber){

      if ( key != DatabaseFunctions.user){  

         Map<String, dynamic> item = {key: value};
        _properties.add(Functions.createItemWithData(item));
      }}}}
  }}});

  Profile profile = Functions.createProfile(widget._listDatabaseId, _properties);


  // Profile profile = new Profile(
  //   updatedAt: document.data[DatabaseFunctions.updatedAt],
  //   objectId: document.documentID,
  //   // image: document[DatabaseFunctions.image].toString(),
  //   databaseId: document.data[DatabaseFunctions.databaseId].toString(),
  //   orderNumber: document.data[DatabaseFunctions.orderNumber],
  //   viewContollerId: document.data[DatabaseFunctions.viewContollerId],
  //   properties: _properties,
  //   type: ProfileType.barista,
  //   );

  return ProfileCard(profile);
}

Widget _buildCard(BuildContext context, DocumentSnapshot document,String databaseId){
  return Column(children: <Widget>[
    
     Text(document.data[DatabaseFunctions.name].toString()),
     Text(document.data[DatabaseFunctions.level].toString()),
     Text(document.data[DatabaseFunctions.age].toString()),
     Text(document.data[DatabaseFunctions.notes].toString())
     
     ]
  );
  }



@override
    Widget build(BuildContext context) {
      return
      StreamBuilder(stream: Firestore.instance.collection(widget._listDatabaseId).snapshots(),initialData: 10,

      builder: (context, snapshot){if (!snapshot.hasData) return const Center(child: Text('Loading'));
      return
      ListView.builder(
        itemExtent: 80,
        itemCount: snapshot.data.documents.length,
        itemBuilder: (BuildContext context, int index) => 
          _buildProfileCard(context, snapshot.data.documents[index], widget._listDatabaseId));
      }
      );
    }
}
  //   @override
  //   Widget build(BuildContext context) {
  //     return ListView( children: <Widget>[

  //         ProfileCard(
  //           _profiles[1]
  //         ),
  //          ProfileCard(
  //           _profiles[2]
  //         ),
  //          ProfileCard(
  //           _profiles[3]
  //         )
  //     ] 
  //   );
  // }



// _profiles = [

//       Profile(  
//             updatedAt: DateTime.now(),
//             objectId: "", type: ProfileType.barista, 
//             properties: [
//               Item(title: "One",value:"One" ,segueId: "One", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
//               Item(title: "One",value:"One" ,segueId: "Two", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
//               Item(title: "One",value:"One" ,segueId: "Three", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
//               Item(title: "One",value:"One" ,segueId: "Four", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ), 
//             ],
//             image: Image.asset('assets/images/user.png'),
//             databaseId: DatabaseFunctions.lot,
//             viewContollerId: ViewControllerIds.lot,
//             orderNumber: 0
//             ),

//       Profile(  
//             updatedAt: DateTime.now(),
//             objectId: "", type: ProfileType.barista, 
//             properties: [
//               Item(title: "One",value:"One" ,segueId: "One", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
//               Item(title: "One",value:"One" ,segueId: "Two", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
//               Item(title: "One",value:"One" ,segueId: "Three", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
//               Item(title: "One",value:"One" ,segueId: "Four", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ), 
//             ],
//             image: Image.asset('assets/images/user.png'),
//             databaseId: DatabaseFunctions.lot,
//             viewContollerId: ViewControllerIds.lot,
//             orderNumber: 0
//             ),
//       Profile(  
//             updatedAt: DateTime.now(),
//             objectId: "", type: ProfileType.barista, 
//             properties: [
//               Item(title: "One",value:"One" ,segueId: "One", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
//               Item(title: "One",value:"One" ,segueId: "Two", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
//               Item(title: "One",value:"One" ,segueId: "Three", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
//               Item(title: "One",value:"One" ,segueId: "Four", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ), 
//             ],
//             image: Image.asset('assets/images/user.png'),
//             databaseId: DatabaseFunctions.lot,
//             viewContollerId: ViewControllerIds.lot,
//             orderNumber: 0
//             ),
//       Profile(  
//             updatedAt: DateTime.now(),
//             objectId: "", type: ProfileType.barista, 
//             properties: [
//               Item(title: "One",value:"One" ,segueId: "One", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
//               Item(title: "One",value:"One" ,segueId: "Two", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
//               Item(title: "One",value:"One" ,segueId: "Three", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
//               Item(title: "One",value:"One" ,segueId: "Four", databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),             
//                           ],
//             image: Image.asset('assets/images/user.png'),
//             databaseId: DatabaseFunctions.lot,
//             viewContollerId: ViewControllerIds.lot,
//             orderNumber: 0
//             ),  