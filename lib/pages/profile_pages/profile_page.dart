import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/pages/overview_page/profile_list.dart';
import 'package:dial_in_v1/data/item.dart';
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
  // ScrollController _scrollController;
  List<Widget> _appBarActions = [Container()];
  List<Widget> _pageBody = List<Widget>();

  ProfilePageModel _profilePageModel;

  void initState() {
    assert(widget.isFromUserFeed != null, 'isFromUserFeed is null');
    getProfile();
    super.initState();
  }

   void getProfile(){
     _profilePageModel = ProfilePageModel(widget.profileReferance, widget.type, widget.isFromUserFeed, widget.isEditing, widget.isOldProfile, widget.isCopying);
    }

  @override
  void dispose() {
    _profilePageModel.dispose();
    super.dispose();
  }


  /// UI Build
  @override
  Widget build(BuildContext context) {
   
    return new 
    ScopedModel(
        model: _profilePageModel,
        child: 
        
        StreamBuilder<Profile>(
            stream: _profilePageModel.profileStream,
            builder: (BuildContext context, AsyncSnapshot<Profile> snapshot){
            
             getBody(snapshot.data);

              Scaffold(

                appBar: PreferredSize(preferredSize: Size.fromHeight(30) ,child: ProfilePageAppBar()),
                body: ListView(
                  // controller: _scrollController,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _pageBody),

                        /// All below changes depending on profile
                        _returnPageStructure(),
                      ],
                    )
                  ],
                ),
                bottomNavigationBar: _returnBottomBar());
                }
        )
    );
  }

  /// Setup the body of the profile page
  void getBody(Profile profile) {
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
                  child: CircularProfilePicture(profile, 200.0)),
            ),
            onTap: _profilePageModel.isEditing
                ? () {
                    _getimage( (image) {
                      setState(() {
                        profile.imageUrl = image;
                      });
                    });
                  }
                : () {}),
      ),

      Expanded(
        child: Container(),
      ),
    ];

    if (!widget.isFromUserFeed) {
      if (_profilePageModel.isEditing) {
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
  Widget _returnBottomBar() {
    Widget _bottomBar;

    if (_profilePageModel.isOldProfile) {
      _bottomBar = Material(
          child: Material(
        color: Theme.of(context).primaryColor,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CopyProfileButton(_profilePageModel.profile),
              DeleteProfileButton(_profilePageModel.profile)
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

    switch (_profilePageModel.profile.type) {
      case ProfileType.barista:
        _structure =
            BaristaPage(_profilePageModel.profile, _margin, _profilePageModel.profile.setItemValue, _profilePageModel.isEditing);
        break;

      case ProfileType.coffee:
        _structure = CoffeeProfilePage(
            _profilePageModel.profile, _profilePageModel.profile.setItemValue, _profilePageModel.isEditing, showPickerMenu);
        break;

      case ProfileType.equipment:
        _structure = EquipmentPage(_profilePageModel.profile, _margin, _profilePageModel.profile.setItemValue,
            _profilePageModel.isEditing, showPickerMenu);
        break;

      case ProfileType.water:
        _structure = WaterPage(_profilePageModel.profile, _profilePageModel.profile.setItemValue, _profilePageModel.isEditing);
        break;

      case ProfileType.recipe:
        _structure = RecipePage(_profilePageModel.profile, (key, value) {
          setState(() => _profilePageModel.profile.setItemValue(key, value));
        }, _showProfileList, _profilePageModel.isEditing);
        break;

      case ProfileType.grinder:
        _structure = GrinderPage(_profilePageModel.profile, _margin, _profilePageModel.profile.setItemValue,
            _profilePageModel.isEditing, showPickerMenu);
        break;

      default:
        break;
    }

    return _structure;
  }

  void showPickerMenu(Item item,) {
    List<Widget> _items = new List<Widget>();
    double _itemHeight = 40.0;

    if (item.inputViewDataSet != null && item.inputViewDataSet.length > 0) {
      item.inputViewDataSet[0].forEach((itemText) {
        _items.add(Center(
            child: Text(
          itemText,
          style: Theme.of(context).textTheme.display2,
        )));
      });
    }

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {

         
          if (item.inputViewDataSet != null &&
              item.inputViewDataSet.length < 1) {
            return Center(
              child: Text('Error No Data for picker'),
            );
          } else {
            int startItem = item.inputViewDataSet[0]
                .indexWhere((value) => (value == item.value));

            FixedExtentScrollController _scrollController =
                new FixedExtentScrollController(initialItem: startItem);

            return Container(
                child: SizedBox(
                    height: 200.0,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Material(
                            elevation: 5.0,
                            shadowColor: Colors.black,
                            color: Theme.of(context).accentColor,
                            type: MaterialType.card,
                            child: Container(
                              height: 40.0,
                              width: double.infinity,
                              alignment: Alignment(1, 0),
                              child: FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Done')),
                            )),
                        SizedBox(
                          height: 160.0,
                          width: double.infinity,
                          child: CupertinoPicker(
                              scrollController: _scrollController,
                              useMagnifier: true,
                              onSelectedItemChanged: (value) {
                                setState(() {
                                  _profilePageModel.profile.setItemValue(item.databaseId,
                                      item.inputViewDataSet[0][value]);
                                });
                              },
                              itemExtent: _itemHeight,
                              children: _items),
                        )
                      ],
                    )));
          }
        }).then((nul) {
      // TODO
      // _scrollController
      // .animateTo(_scrollController.position.pixels + 1000.0 ,curve: Curves.easeInOut, duration: Duration(seconds: 1));
    });
  }

  /// Get image for profile photo
  Future _getimage( Function(String) then) async {
    await showDialog(
            context: context,
            builder: (BuildContext context) => CupertinoImagePicker())
        .then((imageFilePath) =>
            setState(() => _profilePageModel.profile.imageFilePath = imageFilePath));
  }

  /// TODO;
  void _moveScreenForBottomSheet() {
    // _scrollController.animateTo
    // (_scrollController.position.pixels + 190.0,
    // duration: Duration(milliseconds: 500),
    // curve: Curves.easeIn);
  }

  //// Show Profiles list
  void _showProfileList(ProfileType profileType) async {
    // flutter defined function
    var result;

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Center(
              child: Container(
                  height: 400.0,
                  child: SimpleDialog(
                    title: Text(Functions.convertDatabaseIdToTitle(
                        Functions.getProfileTypeDatabaseId(profileType))),
                    children: <Widget>[
                      /// Add profile button
                      RaisedButton(
                        onPressed: () => createNewProfilePage(_profilePageModel.profile.type)
                            .then(handleProfileselectionResult),
                        child: Text('Add new profile'),
                      ),

                      /// Profiles list
                      ProfileListDialog(
                        profileType,
                        (sentProfile) {
                          setState(() {
                            _profilePageModel.profile.setSubProfile(sentProfile);
                          });
                        },
                      )
                    ],
                  )));
        });
    return result;
  }

  void handleProfileselectionResult(dynamic result) {
    if (result is bool) {
      if (result != false) {
        Navigator.pop(context, result);
      }
    } else if (result is Profile) {
      _profilePageModel.profile.setSubProfile(result);
      Navigator.pop(context, result);
    } else {
      throw ('Wrong type in return');
    }
  }

  Future<dynamic> createNewProfilePage(ProfileType profileType) async {

    Profile _newProfile = await Profile.createBlankProfile(profileType);

    /// Result to be passed back to
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>

                /// New Profile goes into Profile page
                ProfilePage(
                  isFromUserFeed: false,
                  isOldProfile: false,
                  isFromProfile: true,
                  isCopying: false,
                  isEditing: true,
                  isNew: true,
                  type: profileType,
                  referance: '',
                )));
    return result;
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

class ProfilePicture extends StatefulWidget {
  final double _margin = 10.0;
  final bool _isEditing;
  final Profile _profile;
  final Function _getImage;

  ProfilePicture(this._isEditing, this._profile, this._getImage);

  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  void onPictureTap() {
    if (widget._isEditing) {
      widget._getImage(

          ///Callback with imagePath
          (image) {
        setState(() {
          widget._profile.imageUrl = image;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) =>

      /// Profile Image
      Container(
          padding: EdgeInsets.all(widget._margin),
          child: InkWell(
            onTap: onPictureTap,
            child: Hero(
              tag: widget._profile.objectId,
              child: SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: CircularProfilePicture(widget._profile, 200.0)),
            ),
          ));
}

class ProfilePageAppBar extends StatefulWidget {
  ProfilePageAppBar();
  _ProfilePageAppBarState createState() => _ProfilePageAppBarState();
}

class _ProfilePageAppBarState extends State<ProfilePageAppBar> {

  List<Widget> _appBarActions;
  
  /// Setup bottom bar
  void setupAppBarActions(ProfilePageModel model) {
    if (!model.isFromUserFeed) {
      model.isEditing
          ? _appBarActions[0] = RawMaterialButton(
              child: Icon(Icons.save_alt), onPressed:() => saveFunction(model))
          : _appBarActions[0] = RawMaterialButton(
              child: Icon(Icons.edit),
              onPressed: () {
                setState(() { model.isEditing = true; });
              });
    }
  }

  /// save button function
  void saveFunction(ProfilePageModel model) async {
    if (model.isOldProfile) {
      PopUps.showCircularProgressIndicator(context);
      await Dbf.updateProfile(model.profile);
      Navigator.pop(context);
      Navigator.pop(context, model.profile);
    } else {
      PopUps.showCircularProgressIndicator(context);
      var newProfile = await Dbf.saveProfile(model.profile);
      Navigator.pop(context);
      Navigator.pop(context, newProfile);
    }
  }

  @override
  Widget build(BuildContext context) => 
  

  ScopedModelDescendant<ProfilePageModel>(
      builder: (BuildContext context, _, model) {
      
        setupAppBarActions(model);

        AppBar(
              centerTitle: true,
              title: Text(
                model.appBarTitle(),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
              ),
              automaticallyImplyLeading: false,
              leading: model.isEditing
                  ? RawMaterialButton(
                      child: Icon(Icons.cancel),
                      onPressed: () { model.isEditing = false; })
                  : GoBackAppBarButton,
              actions: _appBarActions,
        );
      }
    );
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
  Widget build(BuildContext context) =>
  ScopedModelDescendant<ProfilePageModel>(
      builder: (BuildContext context, _, model) => 
      
   RawMaterialButton(
        child: Icon(Icons.cancel),
        onPressed: () {
          setState(() {
            // widget._isEditing = false;
          });
        }
    )
  );
}
