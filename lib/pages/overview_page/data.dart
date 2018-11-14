import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/strings.dart';
import '../../widgets/custom_widgets.dart';
import '../sign_up.dart';
import '../../theme/appColors.dart';
import 'profile_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../database_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../data/images.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import '../../data/profile.dart';
import '../../data/item.dart';

class DataPage extends StatefulWidget {
  @override
  DataPageState createState() => new DataPageState();
}

class DataPageState extends State<DataPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  TabViewDataArray _lists;

  @override
  void initState() {
    super.initState();
    _lists = TabViewDataArray([
      TabViewData(
        ProfileList(DatabaseFunctions.recipe),
        Tab(icon: Icon(Icons.public))),
      TabViewData(
        ProfileList(DatabaseFunctions.coffee),
        Tab(icon: Icon(Icons.list)),
      ),
      TabViewData(
        ProfileList(DatabaseFunctions.grinder),
        Tab(icon: Icon(Icons.portrait)),
      ),
      TabViewData(
        ProfileList(DatabaseFunctions.brewingEquipment),
        Tab(icon: Icon(Icons.portrait)),
      ),
      TabViewData(
        ProfileList(DatabaseFunctions.water),
        Tab(icon: Icon(Icons.portrait)),
      ),
      TabViewData(
        ProfileList(DatabaseFunctions.Barista),
        Tab(icon: Icon(Icons.portrait)),
      ),
    ]);
    controller = new TabController(vsync: this, length: _lists.ref.length);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

//
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              child: Material(
                color: AppColors.getColor(ColorType.toolBar),
                child: TabBar(
                    indicatorPadding: EdgeInsets.all(0.0),
                    labelPadding: EdgeInsets.all(0.0),
                    controller: controller,
                    // isScrollable: true,
                    tabs: <Widget>[
                      _lists.ref[0].tab,
                      _lists.ref[1].tab,
                      _lists.ref[2].tab,
                      _lists.ref[3].tab,
                      _lists.ref[4].tab,
                      _lists.ref[5].tab,
                    ]),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: <Widget>[
                  _lists.ref[0].screen,
                  _lists.ref[1].screen,
                  _lists.ref[2].screen,
                  _lists.ref[3].screen,
                  _lists.ref[4].screen,
                  _lists.ref[5].screen,
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: AddButton(() {
          setState(() {

            
          });
        }));
  }
}

            // DatabaseFunctions.getCurrentUserId((userId) {
            //   Firestore.instance.collection('Barista').document().setData({
            //     'name': 'Willy',
            //     'user': userId,
            //     'notes': 'nothing yet',
            //     'level': 'bottom',
            //   });
            // });

            // DatabaseFunctions.saveProfile(new Profile(
            //     databaseId: DatabaseFunctions.Barista,
            //     // image: image,
            //     orderNumber: 0,
            //     properties: [
            //       Item(databaseId: 'name', value: 'Ian'),
            //       Item(databaseId: 'level', value: 'Junior'),
            //       Item(databaseId: 'notes', value: 'Shitty'),
            //       Item(databaseId: 'age', value: '24'),
            //     ]
            //   )
            // );

// Firestore.instance
// .collection('Barista')
// // .where("topic", isEqualTo: "flutter")
// .snapshots()
// .listen((data) =>
//     data.documents.forEach((doc) => print(doc["name"]))); }),

//  AssetImage assetImage = new AssetImage( 'assets/images/pencil.png');
//     Image thing = new Image(image:assetImage);

//     Firestore.instance.
//     collection('Barista').
//     document()
//     .setData({
//         'name': 'jane',
//         'user': DatabaseFunctions.getCurrentUserId() ,
//         'notes': 'nothing yet',
//         'level': 'bottom',
//         // 'array': List<String>('One': 'yes','two':'fuck')
//         }
//     );

//     Firestore.instance.
//     collection('Barista').
//     document()
//     .setData({
//         'name': 'billy',
//         'user':  DatabaseFunctions.getCurrentUserId(),
//         'notes': 'nothing yet',
//         'level': 'top',
//         // 'array': List<String>('One': 'yes','two':'fuck')

//         });

//     Firestore.instance.
//     collection('Barista').
//     document()
//     .setData({
//         'name': 'tom',
//         'user': DatabaseFunctions.getCurrentUserId() ,
//         'notes': 'nothing yet',
//         'level': 'bottom',
//         // 'array': List<String>('One': 'yes','two':'fuck')
//         }
//     );
