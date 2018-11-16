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
import '../profile_page.dart';

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
        ProfileList(DatabaseIds.recipe),
        Tab(icon: Icon(Icons.list),),
        ProfileType.recipe
      ),
        
      TabViewData(
        ProfileList(DatabaseIds.coffee),
        Tab(icon: Icon(Icons.rounded_corner)),
        ProfileType.coffee
      ),
      TabViewData(
        ProfileList(DatabaseIds.grinder),
        Tab(icon: Icon(Icons.cloud_off)),
        ProfileType.grinder
      ),
      TabViewData(
        ProfileList(DatabaseIds.brewingEquipment),
        Tab(icon: Icon(Icons.watch_later)),
        ProfileType.equipment
      ),
      TabViewData(
        ProfileList(DatabaseIds.water),
        Tab(icon: Icon(Icons.branding_watermark)),
        ProfileType.water
      ),
      TabViewData(
        ProfileList(DatabaseIds.Barista),
        Tab(icon: Icon(Icons.people)),
        ProfileType.barista
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

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
          ProfilePage(isCopying: false, isEditing: false, isNew: true, type: _lists.ref[controller.index].type, referance: '',)));

        }));
  }
}

            // DatabaseIds.getCurrentUserId((userId) {
            //   Firestore.instance.collection('Barista').document().setData({
            //     'name': 'Willy',
            //     'user': userId,
            //     'notes': 'nothing yet',
            //     'level': 'bottom',
            //   });
            // });

            // DatabaseIds.saveProfile(new Profile(
            //     databaseId: DatabaseIds.Barista,
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
//         'user': DatabaseIds.getCurrentUserId() ,
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
//         'user':  DatabaseIds.getCurrentUserId(),
//         'notes': 'nothing yet',
//         'level': 'top',
//         // 'array': List<String>('One': 'yes','two':'fuck')

//         });

//     Firestore.instance.
//     collection('Barista').
//     document()
//     .setData({
//         'name': 'tom',
//         'user': DatabaseIds.getCurrentUserId() ,
//         'notes': 'nothing yet',
//         'level': 'bottom',
//         // 'array': List<String>('One': 'yes','two':'fuck')
//         }
//     );
