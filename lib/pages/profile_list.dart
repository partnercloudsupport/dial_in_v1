import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/strings.dart';
import '../widgets/custom_widgets.dart';
import 'sign_up.dart';
import '../theme/appColors.dart';
import 'data.dart';
import '../data/profile.dart';
import 'feed.dart';
import '../data/item.dart';
import '../database_functions.dart';

class ProfileList extends StatefulWidget{
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
 }

Widget _buildProfileCard(){
  return Text('Cock');
}


 @override
    Widget build(BuildContext context) {
      return _profiles.length > 0 ? ListView.builder(
        itemBuilder: (BuildContext context, int index) =>  ProfileCard(_profiles[index]),
        itemCount: _profiles.length,
      ) : Center(child: Text('No Data'),);
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