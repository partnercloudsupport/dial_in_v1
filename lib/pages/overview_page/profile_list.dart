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

@override
    Widget build(BuildContext context) {
      return
      StreamBuilder(
      stream: Firestore.instance.collection(widget._listDatabaseId).snapshots(),initialData: 10,

     builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return LinearProgressIndicator();
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
                            height: 100.0,
                            width: 100.0,
                            child: new FutureBuilder(
                                future: Functions.buildProfileCardArray(context, snapshot, widget._listDatabaseId),
                                builder: (BuildContext context,
                                    AsyncSnapshot futureSnapshot) {
                                  switch (futureSnapshot.connectionState) {
                                    case ConnectionState.none:
                                      return Text('Press button to start.');
                                    case ConnectionState.active:
                                    case ConnectionState.waiting:
                                      return Text('Awaiting result...');
                                    case ConnectionState.done:
                                      if (futureSnapshot.hasError)
                                        return Text(
                                            'Error: ${futureSnapshot.error}');
                                      return 
                                      ListView.builder(
                                          itemExtent: 80,
                                          itemCount: futureSnapshot.data.length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              futureSnapshot.data[index]);
                                  }
                                  return null; // unreachable
                                }));
                      }
                  }
                }
      );
    }
}
