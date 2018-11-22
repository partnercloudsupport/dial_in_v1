import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    @override
    initState(){
    super.initState();
 }


Widget _buildProfileCard(BuildContext context, DocumentSnapshot document, String databaseId){

  Profile profile = Functions.createProfileFromDocumentSnapshot(widget._listDatabaseId, document);

  return ProfileCard(profile, (){ });
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
