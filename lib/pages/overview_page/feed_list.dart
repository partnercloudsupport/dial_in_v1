import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/functions.dart';
import '../../data/strings.dart';
import '../profile_pages/profile_page.dart';
import '../../database_functions.dart';

class FeedList extends StatefulWidget{

 final bool _public;
 final Function(Profile) _giveProfile;
 final bool _isOnOverviewScreen;

 FeedList(this._public, this._giveProfile, this._isOnOverviewScreen);

 _FeedListState createState() => new _FeedListState();
}


class _FeedListState extends State<FeedList>{

  Function(Profile) _giveProfile;
  bool _public;
  bool _isOnOverviewScreen;

    @override
    initState(){
    _giveProfile = widget._giveProfile; 
    _public = widget._public;
    _isOnOverviewScreen = widget._isOnOverviewScreen;
    super.initState();
   }

   void _dealWithProfileSelection(Profile profile){

     if (_isOnOverviewScreen){

       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
        ProfilePage(isOldProfile: true, isCopying: false, isEditing: true, isNew: false, type: profile.type, referance: profile.objectId, profile: profile)));

     }else{

       _giveProfile(profile);
       Navigator.pop(context);
     }
   }

@override
    Widget build(BuildContext context) {
      return
      StreamBuilder(
      stream: Firestore.instance.collection(DatabaseIds.recipe).snapshots(),
      initialData: 10,
      builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none: return const Center(child: Text('No internet connection'));
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Loading'));
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error'));
                      } else if (snapshot.data.documents.length < 1) {
                        return const Center(child: Text('No data'));
                      } else {
                        return new Container(
                            height: 200.0,
                            width: 150.0,
                            child: new FutureBuilder(
                                future: Functions.buildFeedCardArray(context, snapshot, _dealWithProfileSelection),
                                builder: (BuildContext context, AsyncSnapshot futureSnapshot) {
                                  switch (futureSnapshot.connectionState) {
                                    case ConnectionState.none: return Text('Press button to start.');  
                                    case ConnectionState.active:
                                    case ConnectionState.waiting: return Center(child: Text(StringLabels.loading));                                     
                                    case ConnectionState.done:
                                      if (futureSnapshot.hasError){return Text('Error: ${futureSnapshot.error}');}
                                      else if (futureSnapshot.data == null){ return Center(child: Text(StringLabels.noData));}
                                      else{
                                      List<dynamic> list = futureSnapshot.data;
                                      List<dynamic> reversedlist = list.reversed.toList();
                                      return 
                                      ListView.builder(
                                          itemExtent: 400,
                                          itemCount: reversedlist.length,
                                          itemBuilder: (BuildContext context, int index) =>
                                              reversedlist[index]);}
                                  }
                                  return null; // unreachable
                                }));
                      }
                  }
                }
      );
    }
}
