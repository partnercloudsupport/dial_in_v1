import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/strings.dart';
import '../../widgets/custom_widgets.dart';
import '../../data/profile.dart';
import '../../data/item.dart';
import '../../database_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileList extends StatefulWidget{

 final String _listDatabaseId = 'Barista';

 _ProfileListState createState() => new _ProfileListState();
}


class _ProfileListState extends State<ProfileList>{

    List<Profile> _profiles;

    @override
    initState(){

    _profiles = [

      Profile(  
            updatedAt: DateTime.now(),
            objectId: "", type: ProfileType.barista, 
            properties: [
              Item(title: "One",value:"One" ,segueId: "One",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
              Item(title: "One",value:"One" ,segueId: "Two",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
              Item(title: "One",value:"One" ,segueId: "Three",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
              Item(title: "One",value:"One" ,segueId: "Four",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ), 
            ],
            image: Image.asset('assets/images/user.png'),
            databaseId: DatabaseFunctions.lot,
            viewContollerId: ViewControllerIds.lot,
            orderNumber: 0
            ),

      Profile(  
            updatedAt: DateTime.now(),
            objectId: "", type: ProfileType.barista, 
            properties: [
              Item(title: "One",value:"One" ,segueId: "One",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
              Item(title: "One",value:"One" ,segueId: "Two",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
              Item(title: "One",value:"One" ,segueId: "Three",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
              Item(title: "One",value:"One" ,segueId: "Four",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ), 
            ],
            image: Image.asset('assets/images/user.png'),
            databaseId: DatabaseFunctions.lot,
            viewContollerId: ViewControllerIds.lot,
            orderNumber: 0
            ),
      Profile(  
            updatedAt: DateTime.now(),
            objectId: "", type: ProfileType.barista, 
            properties: [
              Item(title: "One",value:"One" ,segueId: "One",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
              Item(title: "One",value:"One" ,segueId: "Two",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
              Item(title: "One",value:"One" ,segueId: "Three",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
              Item(title: "One",value:"One" ,segueId: "Four",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ), 
            ],
            image: Image.asset('assets/images/user.png'),
            databaseId: DatabaseFunctions.lot,
            viewContollerId: ViewControllerIds.lot,
            orderNumber: 0
            ),
      Profile(  
            updatedAt: DateTime.now(),
            objectId: "", type: ProfileType.barista, 
            properties: [
              Item(title: "One",value:"One" ,segueId: "One",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
              Item(title: "One",value:"One" ,segueId: "Two",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
              Item(title: "One",value:"One" ,segueId: "Three",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),
              Item(title: "One",value:"One" ,segueId: "Four",viewControllerId: "One",databaseId: "One",placeHolderText: "One", keyboardType:TextInputType.text ),             
                          ],
            image: Image.asset('assets/images/user.png'),
            databaseId: DatabaseFunctions.lot,
            viewContollerId: ViewControllerIds.lot,
            orderNumber: 0
            ),
    ];

    super.initState();
 }

Widget _buildProfileCard(BuildContext context, DocumentSnapshot document){

  List<Item> _properties= new List<Item>();

  for (var i = 0; i < document.data.entries.length; i++) {

      if (
      document.data[i].toString() != DatabaseFunctions.updatedAt ||
      document.data[i].toString() != DatabaseFunctions.objectId ||
      document.data[i].toString() != DatabaseFunctions.databaseId ||
      document.data[i].toString() != DatabaseFunctions.type ||
      document.data[i].toString() != DatabaseFunctions.orderNumber ||
      document.data[i].toString() != DatabaseFunctions.orderNumber
      ){

        _properties.add(document.data[i]);
        
      }

  }
  Profile profile = new Profile(
    updatedAt: document[DatabaseFunctions.updatedAt],
    objectId: document[DatabaseFunctions.objectId].toString(),
    // image: document[DatabaseFunctions.image].toString(),
    databaseId: document[DatabaseFunctions.databaseId].toString(),
    type: document[DatabaseFunctions.type],
    orderNumber: document[DatabaseFunctions.orderNumber],
    viewContollerId: document[DatabaseFunctions.viewContollerId],
    properties: _properties
    );

  return ProfileCard(profile);
}


@override
    Widget build(BuildContext context) {
      return _profiles.length > 0 ? 
      StreamBuilder(stream: Firestore.instance.collection(widget._listDatabaseId).snapshots(),
      builder: (context, snapshot){if (!snapshot.hasData) return const Center(child: Text('Loading'),) ;
      return
      ListView.builder(
        itemBuilder: (BuildContext context, int index) =>  ProfileCard(_profiles[index]),
        itemCount: _profiles.length,
      );
      
      
      })
       : Center(child: Text('No Data'),);
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
}