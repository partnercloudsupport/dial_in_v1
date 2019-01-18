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
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

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
  final Profile profile; 

  ProfilePage
  ({this.isFromUserFeed, this.isOldProfile, this.isCopying, this.isEditing, 
  this.isNew, this.type, this.referance, this.profile, this.isFromProfile,}); 

  ProfilePageState createState() => new ProfilePageState();
}
class ProfilePageState extends State<ProfilePage> {

  double _margin = 10.0;
  bool _isEditing;
  bool _isOldProfile;
  Profile _profile;
  String _appBarTitle;
  // ScrollController _scrollController;
  List<Widget> _appBarActions = [ Container()];
  List<Widget> _pageBody = List<Widget>();
  ///TODO refactor into profile model
  ProfilePageModel _ratioModel;
  ///TODO


  /// init state
  void initState() {
      assert( widget.isFromUserFeed != null, 'isFromUserFeed is null' );
      _isEditing = widget.isEditing;
      _profile = widget.profile;
      _isOldProfile = widget.isOldProfile; 
      // _scrollController = ScrollController();

    if (widget.isFromUserFeed && this.widget.referance != null)
    { this._appBarTitle = "${this.widget.referance}'s Recipe"; } 
    
    else{
    if (widget.isNew || widget.isCopying) { this._appBarTitle = StringLabels.newe + ' ' + Functions.getProfileTypeString(_profile.type);
    }else if (widget.isEditing){  this._appBarTitle =  StringLabels.editing + ' ' + Functions.getProfileTypeString(_profile.type);}
    else{this._appBarTitle =  Functions.getProfileTypeString(_profile.type);}
    }
    getBody();
    _ratioModel = ProfilePageModel(Functions.getIntValue(_profile.getItemValue(DatabaseIds.brewingDose)),
                        Functions.getIntValue(_profile.getItemValue(DatabaseIds.yielde)),
                        Functions.getIntValue(_profile.getItemValue(DatabaseIds.brewWeight)));
    super.initState();
  }

  @override
    void didUpdateWidget(ProfilePage oldWidget) {
      
     if (widget.isEditing){  this._appBarTitle =  StringLabels.editing + ' ' + Functions.getProfileTypeString(_profile.type);}
      super.didUpdateWidget(oldWidget);
    }

  @override
  void dispose() {
    _ratioModel.dispose();
    super.dispose();
  }

   /// Setup bottom bar
  void setupAppBarActions(){
    
    if (!widget.isFromUserFeed){
    _isEditing? 
      
      _appBarActions[0] = RawMaterialButton(
                            child: Icon(Icons.save_alt),
                            onPressed: saveFunction)   
    : _appBarActions[0] = RawMaterialButton(
                            child: Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                _isEditing = true;
                                print(_isEditing);
                              });
      });}
  }

   /// save button function
  void saveFunction()async{
    if(_isOldProfile ){ 

      PopUps.showCircularProgressIndicator(context);
      await Dbf.updateProfile(_profile);
      Navigator.pop(context);
      Navigator.pop(context, _profile);
    }else{

      PopUps.showCircularProgressIndicator(context);
      var newProfile = await Dbf.saveProfile(_profile);
      Navigator.pop(context); 
      Navigator.pop(context, newProfile); 
    }
  }
 
  /// UI Build
  @override
  Widget build(BuildContext context) {
    getBody();
    setupAppBarActions();
    assert(_appBarTitle != null, '_appBarTitle is null');
    return  new 

    ScopedModel(
      model: _ratioModel,
      child:
    Scaffold(
      /// TODO reimplement into app bar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _appBarTitle,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
        ),
        automaticallyImplyLeading: false,
        leading: _isEditing ? 
        RawMaterialButton(
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
              Navigator.pop(context, false);
              if(!_isOldProfile){ Dbf.deleteFireBaseStorageItem(_profile.imageUrl);}
            },
          ),
        actions: _appBarActions,
      ),
      body: 
      ListView(
        // controller: _scrollController,
        children: <Widget>[
          Column(
            children: <Widget>[

            Row(mainAxisAlignment: MainAxisAlignment.center, children: _pageBody),

            /// All below changes depending on profile
             _returnPageStructure(_profile),

            ],
          )
        ],
      ),
      bottomNavigationBar: _returnBottomBar()
      )
    );
  }

  /// Setup the body of the profile page
  void getBody(){

   _pageBody = <Widget>[

          /// Spacer 
      Expanded(child: Container(),),

      /// Profile Image
      Container(padding: EdgeInsets.all(_margin),child: 
        InkWell(child:Hero(tag: _profile.objectId ,child: SizedBox(width: 200.0, height: 200.0,
        child: CircularProfilePicture(_profile, 200.0)) ,),
          onTap: _isEditing?()
          {_getimage(
            (image){ setState(() {_profile.imageUrl = image;});});
          }:(){}),),

      Expanded(child: Container(),),
      ];

    if(!widget.isFromUserFeed){

      if(_isEditing){

      _pageBody[2] = PublicProfileSwitch(_profile.isPublic,
                                        (String id , dynamic isPublic ){setState(() {
                                               _profile.isPublic = isPublic;                                   
                                                                                });
                                           },);
      }
    }
  }   

  /// Bottom bar
  Widget _returnBottomBar(){

    Widget _bottomBar;

    if (this._isOldProfile){

    _bottomBar = Material(child: 
            Material( color: Theme.of(context).primaryColor, child:
            BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[

                  CopyProfileButton(_profile),

                  DeleteProfileButton(_profile)

                ],
              ),
            ),
            )
    );
    }
    return _bottomBar; 
  }       

  /// page structure
  Widget _returnPageStructure(Profile profile){

    Widget _structure;

    switch(profile.type){
      case ProfileType.barista:
      _structure = BaristaPage(_profile, _margin,  _profile.setItemValue, _isEditing);
      break;

      case ProfileType.coffee:
      _structure = CoffeeProfilePage(_profile, _profile.setItemValue, _isEditing, showPickerMenu);
      break;

      case ProfileType.equipment:
      _structure = EquipmentPage(_profile, _margin,  _profile.setItemValue, _isEditing, showPickerMenu);
      break;

      case ProfileType.water:
      _structure = WaterPage(_profile, _profile.setItemValue, _isEditing);
      break;

      case ProfileType.recipe:
      _structure = RecipePage(_profile, (key, value){setState(()=> _profile.setItemValue( key, value));}, _showProfileList, _isEditing );
      break;

      case ProfileType.grinder:
      _structure = GrinderPage(_profile, _margin, _profile.setItemValue, _isEditing, showPickerMenu);
      break;

      default:
      break;
    }

    return _structure;

  }

  void showPickerMenu(Item item){

      List< Widget> _items = new List<Widget>();
      double _itemHeight = 40.0; 
    
      if (item.inputViewDataSet != null && item.inputViewDataSet.length > 0)
      {item.inputViewDataSet[0]
      .forEach((itemText){_items.add(Center(child:Text(itemText, style: Theme.of(context).textTheme.display2,)));});
      }

      showModalBottomSheet(context: context, builder: (BuildContext context){

        // _scrollController.animateTo(_scrollController.position.pixels - 300,curve: Curves.easeInOut, duration: Duration(seconds: 1) );

        if (item.inputViewDataSet != null && item.inputViewDataSet.length < 1)
        {return Center(child: Text('Error No Data for picker'),);  

        }else{

      int startItem = item.inputViewDataSet[0].indexWhere((value) => (value == item.value));

      FixedExtentScrollController _scrollController = new FixedExtentScrollController(initialItem: startItem);
    
          return  
          Container(child: SizedBox(height: 200.0, width: double.infinity, child: Column(children: <Widget>[

            Material(elevation: 5.0, shadowColor: Colors.black, color:Theme.of(context).accentColor, type:MaterialType.card, 
            child: Container(height: 40.0, width: double.infinity, alignment: Alignment(1, 0),
            child: FlatButton(onPressed:() => Navigator.pop(context),
            child: Text('Done')),)),
            
            SizedBox(height: 160.0, width: double.infinity  ,
            child: CupertinoPicker(
              scrollController: _scrollController,
              useMagnifier: true,
              onSelectedItemChanged:
                (value){setState(() {
                  _profile.setItemValue(item.databaseId, item.inputViewDataSet[0][value]);
                });}, 
              itemExtent: _itemHeight,
              children: _items
              ),)
          ],) )
        );
        }
      }
    ).then((nul) { 
      // TODO
      // _scrollController
      // .animateTo(_scrollController.position.pixels + 1000.0 ,curve: Curves.easeInOut, duration: Duration(seconds: 1));
      });
  }

  /// Get image for profile photo
  Future  _getimage(Function(String) then)async{
    
    await showDialog(context: context, builder: (BuildContext context) => CupertinoImagePicker()

    ).then((imageFilePath) => setState(()=> _profile.imageFilePath = imageFilePath));
  }

/// TODO;
  void _moveScreenForBottomSheet(){
    // _scrollController.animateTo
    // (_scrollController.position.pixels + 190.0, 
    // duration: Duration(milliseconds: 500),
    // curve: Curves.easeIn);
  }

  //// Show Profiles list
  void _showProfileList(ProfileType profileType)async{
    // flutter defined function
    var result;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return 
        Center(
        child: Container(height: 400.0, child:
                
         SimpleDialog(
          
          title: Text(Functions.convertDatabaseIdToTitle(Functions.getProfileTypeDatabaseId(profileType))),
          children: <Widget>[

            /// Add profile button
            RaisedButton(
              onPressed: () => createNewProfilePage(profileType).then(handleProfileselectionResult),
              child: Text('Add new profile'),
            ),

            /// Profiles list
              ProfileListDialog(
                profileType,
                (sentProfile){ 
                  setState(() {
                    _profile.setSubProfile(sentProfile);
                      });
                 },
              )
          ],
        )
        )
      );
      }
    );
    return result;
  }

  void handleProfileselectionResult(dynamic result){

    if (result is bool){ 
        if (result != false){ 
            Navigator.pop(context, result);}

    } else if (result is Profile){
         _profile.setSubProfile(result);
         Navigator.pop(context, result);
    } else { throw('Wrong type in return');}
  } 

  Future<dynamic> createNewProfilePage(ProfileType profileType)async{

    Profile _newProfile = await Profile.createBlankProfile(profileType);

        /// Result to be passed back to 
      var result = await Navigator.push(context,

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
            profile: _newProfile,
          )
        )
      );
      return result;
  }
}

class PublicProfileSwitch extends StatefulWidget {
  final bool _ispublic;
  final Function(String , dynamic) _setProfileValue;

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
       child:    ///Public profile switch
          Expanded(child: 
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment:CrossAxisAlignment.center
           ,children: <Widget>[
          Text(StringLabels.public),
          Switch(onChanged: (on){ setState(() {
                   _isPublic = on; 
                  widget._setProfileValue(DatabaseIds.public, on);   
                    });
              }, 
           value: _isPublic,),
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

  void onPictureTap(){

    if( widget._isEditing )
      {widget._getImage(
        ///Callback with imagePath
        (image){ setState(() { widget._profile.imageUrl = image; });});
    }
  }

  @override
  Widget build(BuildContext context) =>

     /// Profile Image
      Container( padding: EdgeInsets.all( widget._margin ),child:
        InkWell( onTap: onPictureTap , child:
          Hero( tag: widget._profile.objectId ,child: 
            SizedBox( width: 200.0, height: 200.0, child: 
              CircularProfilePicture(widget._profile, 200.0)) ,),
                       ));
}


class ProfilePageAppBar extends StatefulWidget {
  String _appBarTitle;
  bool _isEditing;
  bool _isOldProfile;
  bool _isFromUserFeed;
  Profile _profile;

  ProfilePageAppBar();
  _ProfilePageAppBarState createState() => _ProfilePageAppBarState();
}

class _ProfilePageAppBarState extends State<ProfilePageAppBar> {

    bool _isEditing;
    List<Widget> _appBarActions;

    void initState() { 
      super.initState();
      _isEditing = widget._isEditing;
    }

     /// Setup bottom bar
  void setupAppBarActions(){
    
    if (!widget._isFromUserFeed){
    _isEditing? 
      
      _appBarActions[0] = RawMaterialButton(
                            child: Icon(Icons.save_alt),
                            onPressed: saveFunction)   
    : _appBarActions[0] = RawMaterialButton(
                            child: Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                _isEditing = true;
                                print(_isEditing);
                              });
      });}
  }

  /// save button function
  void saveFunction()async{
    if(widget._isOldProfile ){ 

      PopUps.showCircularProgressIndicator(context);
      await Dbf.updateProfile(widget._profile);
      Navigator.pop(context);
      Navigator.pop(context, widget._profile);
    }else{

      PopUps.showCircularProgressIndicator(context);
      var newProfile = await Dbf.saveProfile(widget._profile);
      Navigator.pop(context); 
      Navigator.pop(context, newProfile); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(
          widget._appBarTitle,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
        ),
        automaticallyImplyLeading: false,
        leading: widget._isEditing ? 
        RawMaterialButton(
            child: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                widget._isEditing = false;
                print(_isEditing.toString());
              });
            })
        : GoBackAppBarButton,
        actions: _appBarActions,
    );
  }
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

  _CancelEditingProfileAppBarState createState() => _CancelEditingProfileAppBarState();
}

class _CancelEditingProfileAppBarState extends State<CancelEditingProfileAppBar> {

  bool _isEditing;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
            child: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                // widget._isEditing = false;
              });
            }
    );
  }
}

