import 'package:flutter/material.dart' show AppBar, BuildContext, FontWeight, Icon, Icons, Navigator, RawMaterialButton, Scaffold, State, StatefulWidget, Text, TextStyle, required;
import  '../data/profile.dart';
import '../data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/images.dart';
import '../widgets/custom_widgets.dart';

class ProfilePage extends StatefulWidget{

  @required bool isCopying;
  @required bool isEditing; 
  @required bool isNew;
  @required ProfileType type; 
  @required String referance;

  ProfilePage({this.isCopying, this.isEditing, this.isNew, this.type, this.referance}){
    


    






  
  }
  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{

//  bool isCopying;
//  bool isEditing = widget.isEditing;
//  bool isNew;
//  ProfileType type; 
//  String referance;

  Widget _backCancelButton;
  Widget _saveEditButton;

  void initState() { 

  /// Set back button depending on state
  _backCancelButton =  widget.isEditing ? 
  RawMaterialButton(child: Text(StringLabels.cancel),onPressed:(){ widget.isEditing = false;} ,):  
  RawMaterialButton(child: Text(StringLabels.back),onPressed:(){ Navigator.pop(context); } ,);

  /// Set save button depending on state
  _saveEditButton =  widget.isEditing ? 
  RawMaterialButton(child: Text(StringLabels.save),onPressed:(){ print('big job');} ,):  
  RawMaterialButton(child: Text(StringLabels.edit),onPressed:(){ widget.isEditing = true; } ,);

  super.initState();
  }
 

///
/// UI Build
///
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(title: Text(StringLabels.profile, style: TextStyle( fontWeight: FontWeight.w700),), automaticallyImplyLeading: false,
      leading: _backCancelButton, 
      actions: <Widget>[ _saveEditButton  ],),
      body: Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[

                  /// Profile Image
          Card(child: Image.asset(Images.cherries)),
          Text('daaaata dvwvasdvadf ad ad a'),
          TextField(decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'fvefvva'
                          ),onChanged: (text){}),

                    ///Water Section
          Card(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
            Text(StringLabels.water),
            Row(children: <Widget>[

                        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center ,children: <Widget>[


                        Text('Piss'),

                        Text('flaps '),
                        Container( width: 200.0 ,child:
                        TextField(decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'fvefvva',
                              labelText: 'Licky'
                        ),onChanged: (text){}),),
                         
                           Text('Cock'),
                        ],)

          // Column(children: <Widget>[
          //   Text(StringLabels.profile),
          //   TextField()]),

          // Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
          //   Text(StringLabels.temparature),
          //   TextField()]),


            ],),

            TextField(decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'fvefvva'
                          ),onChanged: (text){}),
            
            
            ],),),


      ],)
      
      ),
      
    );}
}

// body: Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[

//           /// Profile Image
//           Card(child: Image.asset(Images.cherries)),

//           ///Water Section
//           Card(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//             Text(StringLabels.water),
//             Row(children: <Widget>[

//              Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.profile),
//               TextField()]),

//             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.temparature),
//               TextField()]),
//             ],)],),),

//           /// Ratios
          
//           ///Water Section
//           Card(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//             Text(StringLabels.ratios),
//             Row(children: <Widget>[

//             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.brewingDose),
//               TextField()]),

//             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.yield),
//               TextField()]),

//             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.brewWeight),
//               TextField()]),
//             ],)],),),

//           ///Grinder Section
//           Card(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//             Text(StringLabels.grinder),
//             Row(children: <Widget>[

//             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.grinder),
//               TextField()]),

//             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.grindSetting),
//               TextField()]),

//             ],)],),),

//           ///Equipment Section
//           Card(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//             Text(StringLabels.brewingEquipment),
//             Row(children: <Widget>[

//             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.brewingEquipment),
//               TextField()]),

//             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.preinfusion),
//               TextField()]),

//             ],)],),),
            


//             ///Score Section
//             Card(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//             Text(StringLabels.score),
//             Row(children: <Widget>[

//             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.flavour),
//               TextField()]),

//             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.body),
//               TextField()]),

//             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.balance),
//               TextField()]),

//             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
//               Text(StringLabels.afterTaste),
//               TextField()]), 

//             TextField(),

//             ],)],),
//             ),


//       ],
//       ),)     