import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        FontWeight,
        Icon,
        Icons,
        Navigator,
        RawMaterialButton,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        TextStyle,
        required;
import '../../data/profile.dart';
import '../../data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/images.dart';
import '../../data/functions.dart';
import '../../database_functions.dart';

import '../overview_page/profile_list.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import '../../widgets/profile_page_widgets.dart';
import '../../pages/profile_pages/recipe_profile_page.dart';
import '../../pages/profile_pages/water_profile_page.dart';
import '../../pages/profile_pages/equipment_profile_page.dart';
import '../../pages/profile_pages/grinder_profile_page.dart';
import '../../pages/profile_pages/barista_profile_page.dart';
import '../../pages/profile_pages/coffee_profile_page.dart';
import 'dart:io';



class ProfilePage extends StatefulWidget {
  @required
  final bool isCopying;
  @required
  final bool isEditing;
  @required
  final bool isNew;
  @required
  final ProfileType type;
  @required
  final String referance;
  String appBarTitle;
  Profile profile;

  ProfilePage({this.isCopying, this.isEditing, this.isNew, this.type, this.referance, this.profile}) {
    if (isNew || isCopying) {
      this.appBarTitle = StringLabels.newe +
          ' ' +
          Functions.getProfileTypeString(type) +
          ' ' +
          StringLabels.profile;
    }
    if (isNew){ profile = Functions.createBlankProfile(type); }
  }

  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  double _padding = 20.0;
  double _margin = 10.0;
  double _textFieldWidth = 120.0;
  double _cornerRadius = 20.0;
  @required
  bool _isCopying;
  @required
  bool _isEditing;
  @required
  bool _isNew;


  Profile _profile;

  void initState() {
    _isCopying = widget.isCopying;
    _isEditing = widget.isEditing;
    _isNew = widget.isNew;
    _profile = widget.profile;
    super.initState();
  }

@override
void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
}

  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.appBarTitle,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
        ),
        automaticallyImplyLeading: false,
        leading: _isEditing
            ? RawMaterialButton(
                child: Icon(Icons.cancel),
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                    print(_isEditing.toString());
                  });
                })
            : RawMaterialButton(
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
        actions: <Widget>[
          _isEditing
              ? RawMaterialButton(
                  child: Icon(Icons.save_alt),
                  onPressed: () {
                    Navigator.pop(context);
                    DatabaseFunctions.saveProfile(_profile);
                  },
                )
              : RawMaterialButton(
                  child: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                      print(_isEditing);
                    });
                  }),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[


            ///Public profile switch
            Container(padding: EdgeInsets.all(_padding),margin: EdgeInsets.all(_margin),child: 
            Column(children: <Widget>[
            Text(StringLabels.public), 
            Switch(onChanged: (on){setState(() {_profile.isPublic = on;}); }, value: _profile.isPublic,),
            ],),),


            /// Profile Image
              
              ProfileImage(_profile.image),

              FlatButton(
                onPressed: _getimage,
                child: Text(StringLabels.changeImage),
              ),
            
            /// All below changes depending on profile

             _returnPageStructure(_profile)

            ],
          )
        ],
      ),
    );
  }

  Widget _returnPageStructure(Profile profile){

    Widget _structure;

    switch(profile.type){
      case ProfileType.barista:
      _structure = BaristaPage(_profile, _margin, (key, value){ _profile.setProfileItemValue(itemDatabaseId: key, value: value);});
      break;

      case ProfileType.coffee:
      _structure = CoffeeProfilePage(_profile, _margin, (key, value){ _profile.setProfileItemValue(itemDatabaseId: key, value: value);});
      break;

      case ProfileType.equipment:
      _structure = EquipmentPage(_profile, _margin, (key, value){ _profile.setProfileItemValue(itemDatabaseId: key, value: value);});
      break;

      case ProfileType.feed:
      break;

      case ProfileType.grinder:
      _structure = GrinderPage(_profile, _margin, (key, value){ _profile.setProfileItemValue(itemDatabaseId: key, value: value);});
      break;

      case ProfileType.none:
      break;

      case ProfileType.water:
      _structure = WaterPage(_profile, _margin, (key, value){ _profile.setProfileItemValue(itemDatabaseId: key, value: value);});
      break;

      case ProfileType.recipe:
      _structure = RecipePage(_profile, _margin, (key, value){_profile.setProfileItemValue(itemDatabaseId: key, value: value);},_showDialog);
      break;

      default:
      break;
    }

    return _structure;
  }

  Future <Image> _getimage()async{

    File _image;
    
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
          _image = image;
        });
    return Image.file(_image); 
  }

  // // user defined function
  void _showDialog(String databaseID) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SimpleDialog(
          title: Text(Functions.convertDatabaseIdToTitle(databaseID)),
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                print('profile butoon pressed');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProfilePage(
                              isCopying: false,
                              isEditing: false,
                              isNew: true,
                              type: Functions.getProfileDatabaseIdType(
                                  databaseID),
                              referance: '',
                            )));
              },
              child: Text('Add new profile'),
            ),
            ProfileList(databaseID,(sentProfile){ setState(() {
                       _profile.setSubProfile(sentProfile);   
                        }); }, false)
          ],
        );
      },
    );
  }
}

/// End of Page
///

/// Widgets

