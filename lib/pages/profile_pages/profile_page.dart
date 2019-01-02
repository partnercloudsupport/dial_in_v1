import 'package:flutter/material.dart';        
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/pages/overview_page/profile_list.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dial_in_v1/pages/profile_pages/recipe_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/water_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/equipment_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/grinder_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/barista_profile_page.dart';
import 'package:dial_in_v1/pages/profile_pages/coffee_profile_page.dart';
import 'package:dial_in_v1/theme/appColors.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'dart:io';
import 'dart:async';

class ProfilePage extends StatefulWidget {
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
  final String appBarTitle;
  final Profile profile; 

  ProfilePage
  ({this.isOldProfile, this.isCopying, this.isEditing, 
  this.isNew, this.type, this.referance, this.profile, this.isFromProfile, this.appBarTitle}); 

  ProfilePageState createState() => new ProfilePageState();
}
class ProfilePageState extends State<ProfilePage> {
  double _padding = 10.0;
  double _margin = 10.0;
  bool _isCopying;
  bool _isEditing;
  bool _isOldProfile;
  Profile _profile;
  ProfilesModel _model;
  String _appBarTitle;
  ScrollController _scrollController;


  void initState() {
      _isCopying = widget.isCopying;
      _isEditing = widget.isEditing;
      _profile = widget.profile;
      _isOldProfile = widget.isOldProfile; 
      _model = ProfilesModel.of(context);
      _scrollController = ScrollController();
      
    if (widget.isNew || widget.isCopying) { this._appBarTitle = StringLabels.newe + ' ' +Functions.getProfileTypeString(_profile.type) + ' ' + StringLabels.profile;
    }else if (widget.isEditing){  this._appBarTitle =  StringLabels.editing + ' ' + Functions.getProfileTypeString(_profile.type) + ' ' + StringLabels.profile; }
    else{ this._appBarTitle =  Functions.getProfileTypeString(_profile.type) + ' ' + StringLabels.profile; }
  
      super.initState();
  }

  /// UI Build
  @override
  Widget build(BuildContext context) {
    
    return  new Scaffold(
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
                },
              ),
        actions: <Widget>[
          
          _isEditing?  
           RawMaterialButton(
                  child: Icon(Icons.save_alt),
                  onPressed: ()async{ if(_isOldProfile ) 
                    {await DatabaseFunctions.updateProfile(_profile);
                    Navigator.pop(context);}
                    else{
                    var newProfile = await DatabaseFunctions.saveProfile(_profile);
                    Navigator.pop(context, newProfile);
                    _model.add(_profile);}},)
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
             InkWell(child:Hero(tag: _profile.objectId ,child: SizedBox(width: 200.0, height: 200.0,
             child: CircularPicture(_profile.image, 200.0)) ,),
              onTap: _isEditing?()
              {_getimage(
                (image){ setState(() {_profile.image = image;});});
              }:(){}),
            
            /// All below changes depending on profile
             _returnPageStructure(_profile),

            ],
          )
        ],
      ),
      bottomNavigationBar: _returnBottomBar()
      );
  }

  /// Bottom bar
  Widget _returnBottomBar(){

    Widget _bottomBar;

    if (this._isCopying || this._isOldProfile){

    _bottomBar = Material(child: 
            Material( color: AppColors.getColor(ColorType.toolBar), child:
            BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[

                  RawMaterialButton(
                    child: Icon(Icons.content_copy),
                    onPressed: ()async{  
                      Profile _newProfile = _profile;
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                      ProfilePage
                      (isOldProfile: false,
                       isCopying: true, 
                       isEditing: true, 
                       isNew: true, 
                       type: _profile.type, 
                       referance: '',
                       profile: _newProfile ,)));}),

                  RawMaterialButton(
                    child: Icon(Icons.delete),
                    onPressed: ()async{ if(_isOldProfile ) 
                      {ProfilesModel.of(context).delete(_profile);
                      Navigator.pop(context);}}),
                ],),),
              ));
    }
    return _bottomBar; 
  }       

  /// page structure
  Widget _returnPageStructure(Profile profile){

    Widget _structure;

    switch(profile.type){
      case ProfileType.barista:
      _structure = BaristaPage(_profile, _margin, (key, value){ _profile.setProfileItemValue( key,  value);}, _isEditing);
      break;

      case ProfileType.coffee:
      _structure = CoffeeProfilePage(_profile, (key, value){ _profile.setProfileItemValue( key,  value);}, _isEditing);
      break;

      case ProfileType.equipment:
      _structure = EquipmentPage(_profile, _margin, (key, value){ _profile.setProfileItemValue( key,  value);}, _isEditing);
      break;

      case ProfileType.feed:
      break;

      case ProfileType.grinder:
      _structure = GrinderPage(_profile, _margin, (key, value){ _profile.setProfileItemValue( key,  value);}, _isEditing);
      break;

      case ProfileType.none:
      break;

      case ProfileType.water:
      _structure = WaterPage(_profile, (key, value){ _profile.setProfileItemValue( key,  value);}, _isEditing);
      break;

      case ProfileType.recipe:
      _structure = RecipePage(_profile, _margin, (key, value){setState((){_profile.setProfileItemValue( key,  value);});}, _showProfileList, _isEditing);
      break;

      default:
      break;
    }

    return _structure;
  }

  /// Get image for profile photo
  Future  _getimage(Function(String) then)async{
    String url = '';

    await showDialog(context: context, builder: (BuildContext context){
      return Center(child: 
        Container(width: 250.0,
          child: CupertinoActionSheet(title:Text(StringLabels.photoSource),
          actions: <Widget>[

      new CupertinoDialogAction(
          child: const Text(StringLabels.camera),
          isDestructiveAction: false,
          onPressed: ()async{
            showDialog(barrierDismissible: false, context: context ,
            builder: (context) => Center(child:CircularProgressIndicator()
            ));  
            File image = await ImagePicker.pickImage
                              (maxWidth: 640.0, maxHeight: 480.0, source: ImageSource.camera);
            url = await DatabaseFunctions.upLoadFileReturnUrl
            (image,[ProfilesModel.of(context).userId  , DatabaseIds.image, _profile.databaseId],
            errorHandler: (e){
              PopUps.showAlert( 
                StringLabels.error,
                e,
                StringLabels.ok ,
                (){Navigator.of(context).pop();},
                context);});
                Navigator.of(context);
                Navigator.of(context).pop(then(url));
                Navigator.of(context).pop(then(url));
          }
      ),
    
      new  CupertinoDialogAction(
          child: const Text(StringLabels.photoLibrary),
          isDestructiveAction: false,
          onPressed: ()async{ 
            showDialog(barrierDismissible: false, context: context ,
            builder: (context) => Center(child:CircularProgressIndicator()
            ));
            File image = await ImagePicker.pickImage
                              (maxWidth: 640.0, maxHeight: 480.0, source: ImageSource.gallery);
           url = await DatabaseFunctions.upLoadFileReturnUrl
            (image,[ProfilesModel.of(context).userId  , DatabaseIds.image, _profile.databaseId],
            errorHandler: (e){
              PopUps.showAlert( 
                StringLabels.error,
                e,
                StringLabels.ok ,
                (){Navigator.of(context).pop();},
                context);});
                Navigator.of(context);
                Navigator.of(context).pop(then(url));
                Navigator.of(context).pop(then(url));
          }
      ),
    ],)));
    }
    );
  }

/// TODO;
  void _moveScreenForBottomSheet(){
    _scrollController.animateTo
    (_scrollController.position.pixels + 190.0, 
    duration: Duration(milliseconds: 500),
    curve: Curves.easeIn);
  }

  //// user defined function
  void _showProfileList(ProfileType profileType) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return 
        Center(
        child: Container(height: 400.0, child:
                
         SimpleDialog(
          
          title: Text(Functions.convertDatabaseIdToTitle(Functions.getProfileTypeDatabaseId(profileType))),
          children: <Widget>[
            RaisedButton(
              onPressed: ()async{
                Profile _newProfile = await Functions.createBlankProfile(profileType);
                Profile result = await Navigator.push(context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProfilePage(
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
               if (result is bool){ if (result as bool != false){ 
               Navigator.pop(context, result);             
               setState(() 
               {  _profile.setSubProfile(result); });}         
              }},
              child: Text('Add new profile'),
            ),
              ProfileListDialog(
                profileType,
                (sentProfile){ setState((){
                  _profile.setSubProfile(sentProfile);   
                }); },
              false,
            )
          ],
        )
        )
      );
      }
    );
  }
}

