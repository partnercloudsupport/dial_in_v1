import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/pages/profile_pages/recipe_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/water_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/equipment_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/barista_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/coffee_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/grinder_profile_page.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'dart:async';
import 'dart:io';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page_model.dart';


class ProfilePage extends StatefulWidget {

  final ProfilePageModel _model;

  ProfilePage( this._model);

  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  double _margin = 10.0;
  List<Widget> _appBarActions = [Container()];
  List<Widget> _pageBody = List<Widget>();


  void initState() {
    assert(widget._model.isFromUserFeed != null, 'isFromUserFeed is null');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new ScopedModel(
        model: widget._model,

        child: StreamBuilder<bool>(
            stream: widget._model.isEditingStream,
            builder: (BuildContext context, AsyncSnapshot<bool> isEditing) =>
                StreamBuilder<Profile>(
                    stream: widget._model.profileStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<Profile> profile) {
                          
                      
                      if (!profile.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        
                        getBody(profile.data, isEditing.data, widget._model);

                        return Scaffold(
                            appBar: PreferredSize(
                                preferredSize: Size.fromHeight(50),
                                child: ProfilePageAppBar()),
                            body: ListView(
                              children: <Widget>[
                                AbsorbPointer(
                                    absorbing: !isEditing.data,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: _pageBody),

                                        /// All below changes depending on profile
                                        _returnPageStructure(),
                                      ],
                                    )),
                              ],
                            ),
                            bottomNavigationBar:
                                _returnBottomBar(profile.data));
                      }
                    })));
  }

  /// Setup the body of the profile page
  void getBody(Profile profile, bool isEditing, ProfilePageModel model) {
    _pageBody = <Widget>[
      /// Spacer
      Expanded(
        child: Container(),
      ),

      /// Profile Image
      ProfilePageImage(),

      Expanded(child: Container(),),
    ];

    if (!widget._model.isFromUserFeed) {
      if (isEditing) {
        _pageBody[2] = PublicProfileSwitch(
          profile.isPublic,
          (String id, dynamic isPublic) {
            setState(() {
              profile.isPublic = isPublic;
            });
          },
        );
      }
    }
  }

  /// Bottom bar
  Widget _returnBottomBar(Profile profile) {
    Widget _bottomBar;

    if (widget._model.isOldProfile) {
      _bottomBar = Material(
          child: Material(
        color: Theme.of(context).buttonColor,
        child: BottomAppBar(
          color: Theme.of(context).accentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CopyProfileButton(profile),
              DeleteProfileButton(profile)
            ],
          ),
        ),
      ));
    }
    return _bottomBar;
  }

  /// page structure
  Widget _returnPageStructure() {
    Widget _structure;

    switch (widget._model.type) {
      case ProfileType.barista:
        _structure = BaristaPage();
        break;

      case ProfileType.coffee:
        _structure = CoffeeProfilePage();
        break;

      case ProfileType.equipment:
        _structure = EquipmentPage();
        break;

      case ProfileType.water:
        _structure = WaterPage();
        break;

      case ProfileType.recipe:
        _structure = RecipePage();
        break;

      case ProfileType.grinder:
        _structure = GrinderPage();
        break;

      default:
        break;
    }

    return _structure;
  }

  /// Get image for profile photo
  
}

class PublicProfileSwitch extends StatefulWidget {
  final bool _ispublic;
  final Function(String, dynamic) _setProfileValue;

  PublicProfileSwitch(this._ispublic, this._setProfileValue);
  _PublicProfileSwitchState createState() => _PublicProfileSwitchState();
}

class _PublicProfileSwitchState extends State<PublicProfileSwitch> {
  bool _isPublic;

  @override
  void initState() {
    _isPublic = widget._ispublic;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:

          ///Public profile switch
        Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(StringLabels.public),
            Switch(
              onChanged: (on) {
                setState(() {
                  _isPublic = on;
                  widget._setProfileValue(DatabaseIds.public, on);
                });
              },
              value: _isPublic,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePageAppBar extends StatefulWidget {
  ProfilePageAppBar();
  _ProfilePageAppBarState createState() => _ProfilePageAppBarState();
}

class _ProfilePageAppBarState extends State<ProfilePageAppBar> {
  List<Widget> _appBarActions = [
    MaterialButton(onPressed: () {},)
  ];

  void setupAppBarActions(ProfilePageModel model, Profile profile, bool isEditing){

    if (!model.isFromUserFeed) {
      if (isEditing != null){
      isEditing
          ? _appBarActions[0] = RawMaterialButton(
              child: Icon(Icons.save_alt),
              onPressed: () => saveFunction(model, profile))
          : _appBarActions[0] = RawMaterialButton(
              child: Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  model.isEdtingSink.add(true);
                });
              });
      }
    }
  }

  /// save button function
  void saveFunction(ProfilePageModel model, Profile profile) async {
    if (model.isOldProfile) {
      PopUps.showCircularProgressIndicator(context);
      await Dbf.updateProfile(profile);
      Navigator.pop(context);
      Navigator.pop(context, profile);
    } else {
      PopUps.showCircularProgressIndicator(context);
      var newProfile = await Dbf.saveProfile(profile);
      Navigator.pop(context);
      Navigator.pop(context, newProfile);
    }
  }

  dynamic setupLeading(dynamic isEditing, ProfilePageModel model ){

    if(isEditing != null){
      return isEditing ? 
      
      RawMaterialButton(
          child: Icon(Icons.cancel),
          onPressed: () => setState(() {
                model.isEdtingSink.add(false);
              }))
      : GoBackAppBarButton();
    }else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) => ScopedModelDescendant<ProfilePageModel>(
          builder: (BuildContext context, _, model) {
        return StreamBuilder<Profile>(
            stream: model.profileStream,
            builder: (BuildContext context, AsyncSnapshot<Profile> profile) {
              return StreamBuilder<bool>(
                stream: model.isEditingStream,
                builder: (BuildContext context, AsyncSnapshot<bool> isEditing) {
                  setupAppBarActions(model, profile.data, isEditing.data);

                  return AppBar(
                    centerTitle: true,
                    title: Text(model.appBarTitle(isEditing.data),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15.0)),
                    automaticallyImplyLeading: false,
                    leading: setupLeading(isEditing.data, model),
                    actions: _appBarActions,
                  );
                },
              );
            }
            
            
          );
      });
}

class GoBackAppBarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
  
    ScopedModelDescendant<ProfilePageModel>
    ( rebuildOnChange: true, builder: (BuildContext context, _ , ProfilePageModel model) =>
    RawMaterialButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          if ( !model.isOldProfile){ if (model.imageUrl != null && model.imageUrl != '')
           { Dbf.deleteFireBaseStorageItem( model.imageUrl ); }}
          Navigator.pop(context, false);
        },
      )
    );
}

class ProfilePageImage extends StatefulWidget {
  _ProfilePageImageState createState() => _ProfilePageImageState();
}

class _ProfilePageImageState extends State<ProfilePageImage> {

  Future _getimage(ProfilePageModel model) async {
    
   var filePath = await showDialog( context: context,builder: ( BuildContext context ) => CupertinoImagePicker());
   if ( filePath != null ){ 
      PopUps.showCircularProgressIndicator(context);
      if ( model.imageUrl != null && model.imageUrl != '') { Dbf.deleteFireBaseStorageItem(model.imageUrl); }
      String url = await Dbf.upLoadFileReturnUrl(File(filePath), [DatabaseIds.user, model.profile.userId, DatabaseIds.images, model.profile.databaseId]).catchError((e) => print(e));
      setState(() { model.profileImageUrl = url; }); 
      Navigator.pop(context); }
  }

  @override
  Widget build(BuildContext context) =>   /// Profile Image

    ScopedModelDescendant(builder: (BuildContext context ,_, ProfilePageModel model) =>
      Container(
        padding: EdgeInsets.all(20.0),
        child: InkWell(
            child: 
              CircularCachedProfileImage( model.placeholder, model.imageUrl, 200, model.profile.objectId ),
            onTap: model.isEditing
                ? () {_getimage( model );
                  }
                : () {}
        ),
      )   
    );
}

