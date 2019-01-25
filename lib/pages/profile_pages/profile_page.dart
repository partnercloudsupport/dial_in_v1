import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:dial_in_v1/pages/profile_pages/recipe_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/water_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/equipment_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/barista_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/coffee_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/grinder_profile_page.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page_model.dart';

class ProfilePage extends StatefulWidget {
  final bool isFromUserFeed;
  @required
  final bool isCopying;
  @required
  final bool isEditing;
  @required
  final bool isNew;
  @required
  final bool isOldProfile;
  @required
  final bool isFromProfile;
  @required
  final ProfileType type;
  @required
  final String referance;
  final String profileReferance;

  ProfilePage({
    this.isFromUserFeed,
    this.isOldProfile,
    this.isCopying,
    this.isEditing,
    this.isNew,
    this.type,
    this.referance,
    this.profileReferance,
    this.isFromProfile,
  });

  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  double _margin = 10.0;
  List<Widget> _appBarActions = [Container()];
  List<Widget> _pageBody = List<Widget>();

  ProfilePageModel _profilePageModel;

  void initState() {
    assert(widget.isFromUserFeed != null, 'isFromUserFeed is null');
    getProfile();
    super.initState();
  }

  void getProfile() {
    _profilePageModel = ProfilePageModel(
        widget.profileReferance,
        widget.type,
        widget.isFromUserFeed,
        widget.isEditing,
        widget.isOldProfile,
        widget.isCopying,
        widget.isNew);
  }

  @override
  void dispose() {
    _profilePageModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new ScopedModel(
        model: _profilePageModel,
        child: StreamBuilder<bool>(
            stream: _profilePageModel.isEditingStream,
            builder: (BuildContext context, AsyncSnapshot<bool> isEditing) =>
                StreamBuilder<Profile>(
                    stream: _profilePageModel.profileStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<Profile> profile) {
                      if (!profile.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        
                        getBody(profile.data, isEditing.data, _profilePageModel);

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
      Container(
        padding: EdgeInsets.all(_margin),
        child: InkWell(
            child: Hero(
              tag: profile.objectId,
              child: SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: ProfilePicture(profile, 200.0, Shape.circle)),
            ),
            onTap: isEditing
                ? () {_getimage( model ,
                     (image) {setState(() { profile.imageUrl = image; }); });
                  }
                : () {}),
      ),

      Expanded(
        child: Container(),
      ),
    ];

    if (!widget.isFromUserFeed) {
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

    if (_profilePageModel.isOldProfile) {
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

    switch (_profilePageModel.type) {
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
  Future _getimage(ProfilePageModel model, Function(String) then) async {
    
   var filePath = await showDialog( context: context,builder: ( BuildContext context ) => CupertinoImagePicker());
   setState(() { if ( filePath != null ){ model.profileImagePath = filePath; }});
  }
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

// class ProfilePicture extends StatefulWidget {
//   final double _margin = 10.0;
//   final bool _isEditing;
//   final Profile _profile;
//   final Function _getImage;

//   ProfilePicture(this._isEditing, this._profile, this._getImage);

//   _ProfilePictureState createState() => _ProfilePictureState();
// }

// class _ProfilePictureState extends State<ProfilePicture> {
//   void onPictureTap() {
//     if (widget._isEditing) {
//       widget._getImage(

//           ///Callback with imagePath
//           (image) {
//         setState(() {
//           widget._profile.imageUrl = image;
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) =>

//       /// Profile Image
//       Container(
//           padding: EdgeInsets.all(widget._margin),
//           child: InkWell(
//             onTap: onPictureTap,
//             child: Hero(
//               tag: widget._profile.objectId,
//               child: SizedBox(
//                   width: 200.0,
//                   height: 200.0,
//                   child: ProfilePicture(widget._profile, 200.0)),
//             ),
//           ));
// }

class ProfilePageAppBar extends StatefulWidget {
  ProfilePageAppBar();
  _ProfilePageAppBarState createState() => _ProfilePageAppBarState();
}

class _ProfilePageAppBarState extends State<ProfilePageAppBar> {
  List<Widget> _appBarActions = [
    MaterialButton(onPressed: () {},)
  ];

  void setupAppBarActions(
      ProfilePageModel model, Profile profile, bool isEditing) {
    if (!model.isFromUserFeed) {
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
                    leading: isEditing.data
                        ? RawMaterialButton(
                            child: Icon(Icons.cancel),
                            onPressed: () => setState(() {
                                  model.isEdtingSink.add(false);
                                }))
                        : GoBackAppBarButton(),
                    actions: _appBarActions,
                  );
                },
              );
            });
      });
}

class GoBackAppBarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
  }
}

class CancelEditingProfileAppBar extends StatefulWidget {
  final bool _isEditing;
  CancelEditingProfileAppBar(this._isEditing);

  _CancelEditingProfileAppBarState createState() =>
      _CancelEditingProfileAppBarState();
}

class _CancelEditingProfileAppBarState
    extends State<CancelEditingProfileAppBar> {
  bool _isEditing;
  @override
  Widget build(BuildContext context) => ScopedModelDescendant<ProfilePageModel>(
      builder: (BuildContext context, _, model) => RawMaterialButton(
          child: Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              // widget._isEditing = false;
            });
          }));
}
