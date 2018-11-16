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

 final String _listDatabaseId;

 ProfileList(this._listDatabaseId);

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

      if ( key != DatabaseIds.updatedAt){

      if ( key != DatabaseIds.objectId) {

      if ( key != DatabaseIds.databaseId){

      if ( key != DatabaseIds.databaseId){

      if ( key != DatabaseIds.orderNumber){

      if ( key != DatabaseIds.user){  

         Map<String, dynamic> item = {key: value};
        _properties.add(Functions.createItemWithData(item));
      }}}}
  }}});

  Profile profile = Functions.createProfile(widget._listDatabaseId, _properties);

  return ProfileCard(profile);
}

Widget _buildCard(BuildContext context, DocumentSnapshot document,String databaseId){
  return Column(children: <Widget>[
    
     Text(document.data[DatabaseIds.name].toString()),
     Text(document.data[DatabaseIds.level].toString()),
     Text(document.data[DatabaseIds.age].toString()),
     Text(document.data[DatabaseIds.notes].toString())
     
     ]
  );
  }



@override
    Widget build(BuildContext context) {
      return
      StreamBuilder(
      stream: Firestore.instance.collection(widget._listDatabaseId).snapshots(),initialData: 10,

      builder: (context, snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.waiting:
          case ConnectionState.none:
            return LinearProgressIndicator();
          case ConnectionState.active:
          case ConnectionState.done:
        
        print( snapshot.error);

        if (!snapshot.hasData){ return const Center(child: Text('Loading'));}
        else if (snapshot.hasError){ return const Center(child: Text('Error'));}
        else if (snapshot.data.documents.length < 1){ return const Center(child: Text('No data')); }
        else{
      return
      ListView.builder(
        itemExtent: 80,
        itemCount: snapshot.data.documents.length,
        itemBuilder: (BuildContext context, int index) => 
          _buildProfileCard(context, snapshot.data.documents[index], widget._listDatabaseId));}
      }
      }
      );
    }
}
