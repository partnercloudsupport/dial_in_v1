import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/theme/appColors.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/images.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:dial_in_v1/data/item.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'dart:async';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'package:flutter/services.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:flutter/widgets.dart';
import 'package:dial_in_v1/routes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io';



/// Background
class Pagebackground extends StatelessWidget {
  final AssetImage _image;

  Pagebackground(this._image);

  @override
  Widget build(BuildContext context) {
        /// Background
      return  new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: _image,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

/// Dial in logo
class DialInLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Image.asset('assets/images/DialInWhiteLogo.png',
          height: 50.0, width: 50.0),
    );
  }
}

///Text Field entry
class TextFieldEntry extends StatefulWidget {
  final String _placeholder;
  final bool _obscureText;
  final TextEditingController _controller;

  TextFieldEntry(this._placeholder, this._controller, this._obscureText);

  @override
  _TextFieldEntryState createState() => new _TextFieldEntryState();
}
class _TextFieldEntryState extends State<TextFieldEntry> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200.0,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(0.0),
        alignment: const Alignment(0.0, 0.0),
        child: TextFormField(
            obscureText: widget._obscureText,
            controller: widget._controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(const Radius.circular(10.0))),
                filled: true,
                hintText: widget._placeholder,
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.grey.withOpacity(0.7)
                )
        )
    );
  }
}

/// Circular picture
class CircularFadeInAssetNetworkImage extends StatelessWidget {
  final String _image;
  final String _placeHolder;
  final double _size;

  CircularFadeInAssetNetworkImage(this._image,this._placeHolder ,this._size,);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow
          (color: Colors.black, offset: new Offset(0.0, 2.0),blurRadius: 2.0,)],
          shape: BoxShape.circle
        ),
        height:_size,
        width: _size,
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(_size),
          child: 
          
          FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: _placeHolder,
            image: _image
          )
        ),
    );   
  }
}

/// Circular picture
class CircularBox extends StatelessWidget {
  final Widget _child;
  final double _size;

  CircularBox(this._child, this._size,);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow
          (color: Colors.black, offset: new Offset(0.0, 2.0),blurRadius: 2.0,)],
          shape: BoxShape.circle
        ),
        height:_size,
        width: _size,
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(_size),
          child:_child
        ),
    );   
  }
}

class CircularProfilePicture extends StatefulWidget {
  final Profile _profile;
  final double _size;
  CircularProfilePicture(this._profile, this._size);
  _CircularProfilerPictureState createState() => _CircularProfilerPictureState();
}

class _CircularProfilerPictureState extends State<CircularProfilePicture> {

  final BehaviorSubject<Widget> _widgetStreamController = new BehaviorSubject<Widget>();

  void initState() { 
    super.initState();
    _returnImageWidget();
  }

@override
  void didUpdateWidget(CircularProfilePicture oldWidget) {
   _returnImageWidget();
    super.didUpdateWidget(oldWidget);
  }
 @override
 void didChangeDependencies() {
   super.didChangeDependencies();
   _returnImageWidget();
 }

  _returnImageWidget()async{

    if(
      widget._profile.imageFilePath != null &&
      widget._profile.imageFilePath != ''){   
       if (await File(widget._profile.imageFilePath).exists()){
         _widgetStreamController.add(Image.file(File(widget._profile.imageFilePath),
                                                fit: BoxFit.cover,)); 
        }
      }

    else 

   if(
      widget._profile.imageUrl != null &&
      widget._profile.imageUrl != '') {    
      _widgetStreamController.add( FadeInImageAssetNetworkFromProfile(widget._profile));
    } 
    else { 
      _widgetStreamController.add( Image.asset(widget._profile.getImagePlaceholder()));
        }
  }

  Widget setupWidgetView(SnapShotDataState dataState , AsyncSnapshot<Widget> snapshot){
    Widget _returnWidget;
    switch(dataState){
      case SnapShotDataState.waiting: _returnWidget = CircularBox(CircularProgressIndicator(), widget._size); break;
      case SnapShotDataState.noData: _returnWidget =  CircularBox(Icon(Icons.error_outline), widget._size) ;break;
      case SnapShotDataState.hasdata: _returnWidget = CircularBox(snapshot.data, widget._size); break;
      case SnapShotDataState.hasError:
        print(snapshot.error);
        throw(snapshot.error);
        break;
    }   
    assert (_returnWidget != null, '_return widdget is null');
    return  _returnWidget;
  }

  @override
  Widget build(BuildContext context) {
   return 
    StreamBuilder<Widget>(
      stream: _widgetStreamController.stream ,
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){

        switch (snapshot.hasError) {
          case true: return setupWidgetView(SnapShotDataState.hasError, snapshot);
          case false:

          switch (snapshot.hasData) {

            case false: 
              switch(snapshot.connectionState){
                case ConnectionState.none: break;
                case ConnectionState.active: return setupWidgetView(SnapShotDataState.noData, snapshot);
                case ConnectionState.waiting: return setupWidgetView(SnapShotDataState.waiting, snapshot);
                case ConnectionState.done: break;}     
              break;       

            case true: return setupWidgetView(SnapShotDataState.hasdata, snapshot); 
            default:
          }
      }
      }
    );
  }
}

class FadeInImageAssetNetworkFromProfile extends StatelessWidget {

Profile _profile;
FadeInImageAssetNetworkFromProfile(this._profile);

  @override
  Widget build(BuildContext context) =>
    FadeInImage.assetNetwork(
        fit: BoxFit.cover,
        placeholder:_profile.getImagePlaceholder(),
        image: _profile.imageUrl
    );
}





/// Circular picture
// class CircularProfilePicture extends StatelessWidget {

//   final Profile _profile;
//   final double _size;

//   final BehaviorSubject<Widget> _widgetStreamController = new BehaviorSubject<Widget>();

//   CircularProfilePicture(this._profile, this._size);

//   _returnImageWidget()async{

//     if(
//       _profile.imageFilePath != null &&
//       _profile.imageFilePath != ''){   
//        if (await File(_profile.imageFilePath).exists()){
//          _widgetStreamController.add(Image.file(File(_profile.imageFilePath),
//                                                 fit: BoxFit.cover,)); 
//         }
//       }

//     else 

//    if(
//       _profile.imageUrl != null &&
//       _profile.imageUrl != '') {    
//       _widgetStreamController.add( FadeInImage.assetNetwork(
//                                       fit: BoxFit.cover,
//                                       placeholder: _profile.getImagePlaceholder(),
//                                       image: _profile.imageUrl
//                                       ));
//     } 
//     else { 
//       _widgetStreamController.add( Image.asset(_profile.getImagePlaceholder()));
//         }
//   }
  

//   Widget setupWidgetView(SnapShotDataState dataState , AsyncSnapshot<Widget> snapshot){

//     Widget _returnWidget;

//     switch(dataState){
//       case SnapShotDataState.waiting: _returnWidget = CircularBox(CircularProgressIndicator(),_size); break;

//       case SnapShotDataState.noData:_returnWidget =  CircularBox(Icon(Icons.error_outline), _size) ;break;

//       case SnapShotDataState.hasdata:_returnWidget = CircularBox(snapshot.data, _size); break;

//       case SnapShotDataState.hasError:
//         print(snapshot.error);
//         throw(snapshot.error);
//         break;
//     }   
//     assert (_returnWidget != null, '_return widdget is null');
//     return  _returnWidget;
//   }

//   @override
//   Widget build(BuildContext context) {

//     _returnImageWidget();
     
//     return 
//     StreamBuilder<Widget>(
//       stream: _widgetStreamController.stream ,
//       builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){

//            switch (snapshot.hasError) {
//               case true: return setupWidgetView(SnapShotDataState.hasError, snapshot);
//               case false:

//               switch (snapshot.hasData) {

//                 case false: 
//                   switch(snapshot.connectionState){
//                     case ConnectionState.none: break;
//                     case ConnectionState.active: return setupWidgetView(SnapShotDataState.noData, snapshot);
//                     case ConnectionState.waiting: return setupWidgetView(SnapShotDataState.waiting, snapshot);
//                     case ConnectionState.done: break;
//                   }     
//                   break;       

//                 case true: return setupWidgetView(SnapShotDataState.hasdata, snapshot); 
                  
//                 default:
//               }
//           }
//       }
//     );
//   }
// }



/// Action button
class ActionButton extends StatelessWidget {
  final String _buttonTitle;
  final Function _buttonAction;

  ActionButton(this._buttonTitle, this._buttonAction);

  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.orange.shade600.withOpacity(0.6),
      child: Text(_buttonTitle,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0)),
      onPressed: _buttonAction);
  }
}

/// Custom Toolbar
class CustomToolbar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flex(direction: Axis.horizontal),
          SegmentControlButton('Social'),
          Flex(direction: Axis.horizontal),
          SegmentControlButton('Social'),
          Flex(direction: Axis.horizontal),
          SegmentControlButton('Social'),
          Flex(direction: Axis.horizontal),
          SegmentControlButton('Social'),
          Flex(direction: Axis.horizontal)
        ],
      ),
    );
  }
}

///Segmented control button
class SegmentControlButton extends StatelessWidget {
  final String text;
  // final Image image;

  SegmentControlButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      child: RawMaterialButton(
        onPressed: () => {},
        child: Column(
          children: <Widget>[
            Icon(Icons.add),
            Text(text, style: TextStyle(fontSize: 10.0))
          ],
        ),
      ),
    );
  }
}

/// Usercard
class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          ///
          /// User Image
          ///
          Container(
              child: Center(
                  child: CircularFadeInAssetNetworkImage('assets/images/user.png',Images.user, 100.0))),

          Column(
            children: <Widget>[
              ///
              /// User name text
              ///
              Container(
                  margin: EdgeInsets.all(20.0),
                  child: Text(
                    StringLabels.userName,
                    style: TextStyle(fontSize: 20.0),
                  )),

              Container(
                child: Row(
                  children: <Widget>[
                    ///
                    /// Brew count
                    ///
                    Container(
                        padding: EdgeInsets.all(5.0),
                        child:

                            /// Title
                            Column(children: <Widget>[
                          Text(StringLabels.brewCount),

                          /// Value
                          CountLabel('B')
                        ])),

                    ///
                    ///Bean stash
                    ///
                    Container(
                        padding: EdgeInsets.all(5.0),
                        child:

                            ///Title
                            Column(children: <Widget>[
                          Text(StringLabels.beanStash),

                          /// Value
                          CountLabel('C')
                        ]))
                  ],
                ),
              )
            ],
          )
        ]));
  }
}


///Profile card
class ProfileCard extends StatefulWidget {
  
  final Function(Profile) _giveprofile;
  final Function(Profile, BuildContext) _deleteProfile;
  final Profile _profile;
  final _dateFormat = DateFormat.yMd();

  ProfileCard(this._profile, this._giveprofile, this._deleteProfile);


    _ProfileCardState createState() => _ProfileCardState();
}
class _ProfileCardState extends State<ProfileCard> {

  String _topLeft = 'error';
  String _topRight = 'error';
  String _bottomRight = 'error';
  String _bottomleft = 'error';
  double _score;

  @override
  void initState() {
 
  setWidgetUp();
   super.initState();
  }

  @override
    void didUpdateWidget(dynamic oldWidget) {
    setWidgetUp();
    super.didUpdateWidget(oldWidget);
    }

void setWidgetUp(){

   switch(widget._profile.type){
      
      case ProfileType.recipe: 
      
      _topLeft = widget._profile.getProfileProfileTitleValue(profileDatabaseId: DatabaseIds.coffee);
      _topRight = widget._dateFormat.format(widget._profile.getItemValue(DatabaseIds.date));
      _bottomRight = widget._profile.getProfileProfileTitleValue(profileDatabaseId: DatabaseIds.brewingEquipment);
      _bottomleft = 'widget._profile.getTotalScore()';
      _score = widget._profile.getTotalScore();
      break;

      case ProfileType.coffee:  
      _topLeft = widget._profile.getItemValue( DatabaseIds.coffeeId);
      _topRight = widget._profile.getItemValue( DatabaseIds.processingMethod);
      _bottomRight = widget._dateFormat.format(widget._profile.getItemValue(DatabaseIds.roastDate));
      _bottomleft = widget._profile.getItemValue( DatabaseIds.country);
      break;

      case ProfileType.water:   

      if(widget._profile.getItemValue(DatabaseIds.ppm) == '' || 
      widget._profile.getItemValue(DatabaseIds.ppm) == null){ _topRight = '';}
      else{ _topRight = widget._profile.getItemValue(DatabaseIds.ppm) + 'ppm';}

      if(widget._profile.getItemValue(DatabaseIds.waterID) == '' || 
      widget._profile.getItemValue(DatabaseIds.waterID) == null){  _topLeft = '';}
      else{ _topLeft = widget._profile.getItemValue(DatabaseIds.waterID);}

      if(widget._profile.getItemValue(DatabaseIds.gh) == '' || 
      widget._profile.getItemValue(DatabaseIds.gh) == null){  _bottomleft = '';}
      else{ _bottomleft = widget._profile.getItemValue(DatabaseIds.gh) + 'ppm GH';}

      if(widget._profile.getItemValue(DatabaseIds.kh) == '' || 
      widget._profile.getItemValue(DatabaseIds.kh) == null){ _bottomRight = '';}
      else{ _bottomRight = widget._profile.getItemValue(DatabaseIds.kh) +'ppm KH';}

      break;

      case ProfileType.equipment:   
      _topLeft = widget._profile.getItemValue( DatabaseIds.equipmentId);
      _topRight = widget._profile.getItemValue( DatabaseIds.type);
      _bottomRight = '';
      // widget._profile.getProfileItemValue( DatabaseIds.method);
      _bottomleft = widget._profile.getItemValue( DatabaseIds.equipmentModel); 
      break;

      case ProfileType.grinder:   
      _topLeft = widget._profile.getItemValue( DatabaseIds.grinderId);
      _topRight = widget._profile.getItemValue( DatabaseIds.burrs);
      _bottomRight = widget._profile.getItemValue( DatabaseIds.grinderMake);
      _bottomleft = widget._profile.getItemValue( DatabaseIds.grinderModel);      
      break;

      case ProfileType.barista:   
      _topLeft = widget._profile.getItemValue( DatabaseIds.name);
      _topRight = widget._profile.getItemValue( DatabaseIds.level);
      _bottomleft = widget._profile.getItemValue( DatabaseIds.notes);
      _bottomRight = widget._profile.getItemValue( DatabaseIds.age);       
      break;

      default: Error();    
               
      break;
    }
}
  void _editProfile(){
   Navigator.push(context, SlowerRoute((BuildContext context) =>
          ProfilePage(isFromUserFeed: false, isFromProfile: false ,isOldProfile: true, isCopying: false, isEditing: true, isNew: false, type: widget._profile.type, referance: widget._profile.objectId, profile: widget._profile)));
  }
  @override
  Widget build(BuildContext context) {
    return 
    Slidable(
  delegate: new SlidableDrawerDelegate(),
  actionExtentRatio: 0.25,
  secondaryActions: <Widget>[
    new IconSlideAction(
      caption: 'Delete',
      color: Colors.red,
      icon: Icons.delete,
      onTap: () => widget._deleteProfile(widget._profile, context)
,
    ),
    new IconSlideAction(
      caption: 'Edit',
      color: Colors.yellow,
      icon: Icons.edit,
      onTap: _editProfile,
    ),
  ],
  child:
      
   Card(child: Container(padding: EdgeInsets.all(10.0),child: 
      InkWell(onTap:() => widget._giveprofile(widget._profile)
       
      ,child: 
        
      Row(children: <Widget>[
      ///
      /// Profile picture
      ///
      ScalableWidget(Hero(tag: widget._profile.objectId , child: Container (
          child: CircularProfilePicture(widget._profile, 60.0)),)),

      Padding(padding: EdgeInsets.all(5.0)),
          
      Expanded(
          child: Row(children: <Widget>[
        ///
        /// Main name and secondnary details
        ///
        Expanded(
            flex: 8,
            child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child:Text(_topLeft, maxLines: 2, softWrap: true,
                           overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.display1,)),

                      Container(
                              child: widget._profile.type == ProfileType.recipe ? 
                              ScalableWidget(FiveStarRating(widget._profile.getTotalScore().toInt()))  :
                              Text(_bottomleft, maxLines: 1, overflow: TextOverflow.ellipsis,)
                      )
                    ]
                )
            )
        ),

        ///
        /// Third and fourth details
        ///
        Expanded(
            flex:6,
            child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          // margin: EdgeInsets.all(5.0), 
                          child: Text(_topRight, maxLines: 1, overflow: TextOverflow.ellipsis,)),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: Text(_bottomRight, maxLines: 1, overflow: TextOverflow.ellipsis,),
                      )
                    ])))
      ]))
    ]),
    )
    )
    )
    );
  }
}

  class ScalableWidget extends FittedBox{
     ScalableWidget(Widget child) : super(child: child, fit: BoxFit.scaleDown);
  }

///Social card
class SocialProfileCard extends StatelessWidget {

  final Function(UserProfile, int) _giveUserProfile;
  final Function(FeedProfileData) _giveprofile;
  final FeedProfileData _profile;
  final _dateFormat = DateFormat.yMd();
  final int _tag;

  SocialProfileCard(this._profile, this._giveprofile, this._giveUserProfile, this._tag);

  @override
  Widget build(BuildContext context) {

    Widget _description;

    if(
    (_profile.profile.getItemValue(DatabaseIds.descriptors) == '' ||
     _profile.profile.getItemValue(DatabaseIds.descriptors) ==  null) 
     && 
     (_profile.profile.getItemValue(DatabaseIds.notes) == '' || 
     _profile.profile.getItemValue(DatabaseIds.notes) == null)){
      _description = Container(width: 0.0, height: 0.0,);
    }
    else{
          _description =Container(margin: EdgeInsets.all(5.0), child: Text('Notes of ' + _profile.profile.getItemValue(DatabaseIds.descriptors) + 'Info' + _profile.profile.getItemValue(DatabaseIds.notes),  maxLines: 10), );
      }

    return 
    Card(child: Container(child:

      Column(children: <Widget>[

      InkWell(onTap:() => _giveUserProfile(_profile.userProfile, _tag), 
      child:  
      Material (color: Theme.of(context).dividerColor, 
      child: Container(padding: EdgeInsets.all(10.0), child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[

         /// User picture
          Container(child:InkWell(onTap:() => _giveUserProfile(_profile.userProfile, _tag),
              child: Hero(tag: _profile.userProfile.id + _tag.toString(), child: CircularFadeInAssetNetworkImage(_profile.userImage, Images.user , 40.0)))),
              
      
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

            ///User Name
            Container(margin: EdgeInsets.all(5.0), 
            child:  Text(
                      _profile.userProfile.userName ?? '',  
                      maxLines: 1, 
                      style: Theme.of(context).textTheme.display1, 
                      softWrap: true,overflow: 
                      TextOverflow.ellipsis,),),

            /// Date
            Container(
              margin: EdgeInsets.all(5.0), 
              child: Text(
                      _dateFormat.format(_profile.profile.getItemValue(DatabaseIds.date)) ,  
                      maxLines: 1), ),

        ]),
        Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [ 
          
          ///Follow Button
          Container(margin: const EdgeInsets.all(5.0) ,
          child: FollowButton(_profile.userProfile.id),),

          ]) ,)
            
      ],),))),      

      InkWell(onTap:() => _giveprofile(_profile),child: Column(children: <Widget>[

        /// Recipe picture
        Hero(tag: _profile.profile.objectId, child: SizedBox(width: double.infinity, height: 200.0, child:
          Material(type: MaterialType.card, elevation: 2.0 ,color: Theme.of(context).scaffoldBackgroundColor,
          child: FadeInImage.assetNetwork(image:_profile.profile.imageUrl, fit: BoxFit.cover, placeholder: Images.rippleLoadingGif),),),),
        
        ///Spacer
          Container(height: 20.0,),

        /// Coffee Name
        Container(margin: EdgeInsets.all(5.0), child: 
          Text(_profile.profile.getProfileProfileItemValue(ProfileType.coffee, DatabaseIds.coffeeId),  maxLines: 3, style: Theme.of(context).textTheme.display3,),),

          /// Notes
          _description,

          ///Score
          FiveStarRating(_profile.profile.getTotalScore().toInt())  
        ],))      
      ]),
    ));
  }
}

///RatioTextField Item input
class RatioTextFieldItemWithInitalValue extends StatefulWidget {

  final Function(dynamic) _giveValue;
  final Item _item;
  final bool _isEditing;
  final TextAlign textAlign;

RatioTextFieldItemWithInitalValue
(this._item, this._giveValue,this._isEditing,{this.textAlign = TextAlign.center});

 _RatioTextFieldItemWithInitalValueState createState() => _RatioTextFieldItemWithInitalValueState();
}
class _RatioTextFieldItemWithInitalValueState extends State<RatioTextFieldItemWithInitalValue> {

  /// Maybe TODO to format text
  RegExp _filter = RegExp('\.\s');
  BlacklistingTextInputFormatter _spaceBlacklistingTextInputFormatter = BlacklistingTextInputFormatter(RegExp(' '),replacementString: '');
  BlacklistingTextInputFormatter _commaBlacklistingTextInputFormatter = BlacklistingTextInputFormatter(RegExp(','),replacementString: '.');
  WhitelistingTextInputFormatter _whitelistingTextInputFormatter = WhitelistingTextInputFormatter(RegExp('[0-9,.]'));
  List<TextInputFormatter> _inputFormatters = List<TextInputFormatter>();
  TextEditingController _controller;
  FocusNode _focusNode = new FocusNode();
  final double _textFieldWidth = 30.0;


  @override
    void initState() {
      _inputFormatters = [_commaBlacklistingTextInputFormatter,_spaceBlacklistingTextInputFormatter,_whitelistingTextInputFormatter];
      _controller = new TextEditingController(text: widget._item.value);
      _focusNode.addListener(_focusNodeListenerFunction);
    super.initState();
    }

  void _focusNodeListenerFunction(){

    if (!_focusNode.hasFocus){

      _controller.text = widget._item.value.toString();

    }
  }

  @override
  Widget build(BuildContext context) {
 
    return    
    ScopedModelDescendant<ProfilePageModel>
            ( rebuildOnChange: true, builder: (BuildContext context, _ ,ProfilePageModel model) {

      return
      StreamBuilder(
      stream: model.getStream(widget._item.databaseId),
      builder: (BuildContext context, AsyncSnapshot<int> snapShot){

        if(model.isCalculating){
          _controller.text = snapShot.data.toString();
          model.isCalculating = false;}
        
        _focusNodeListenerFunction();

        return
        Expanded(
          flex: 5,
          child: Container(width: _textFieldWidth, padding: EdgeInsets.all(5.0), margin: EdgeInsets.all(5.0), 
            child: TextField(
              focusNode: _focusNode,
              inputFormatters: _inputFormatters ?? <TextInputFormatter>[],
              enabled: widget._isEditing,
              controller: _controller ,
              textAlign: widget.textAlign,
              keyboardType: widget._item.keyboardType,
              decoration: 
                new InputDecoration(
                
                prefixIcon: widget._item.icon ?? null,
                labelText: widget._item.title,
                hintText: widget._item.placeHolderText,
                  ),
                  onChanged: (value) {
                    model.updateValue(widget._item.databaseId,value);
                    widget._giveValue(value);
                  }
                )
              )
            );
          }
        );
      }
    ); 
  }
}       

/// Five star rating
class FiveStarRating extends StatelessWidget {

  final int _score;
  final int _starCount = 5;

  FiveStarRating(this._score);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new StarRating(
        size: 25.0,
        rating: _score/10,
        color: Colors.orange,
        borderColor: Colors.grey,
        starCount: _starCount
      ),
    );
  }
}

/// Cout label
class CountLabel extends StatelessWidget {
  final String _text;

  CountLabel(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.0),
        child: Text(
          _text,
          style: TextStyle(
              color: AppColors.getColor(ColorType.primarySwatch),
              fontSize: 25.0),
        ));
  }
}

/// Add floating action button
class AddButton extends StatelessWidget {

  final Function _onPressed;

  AddButton(this._onPressed);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onPressed,
      child: Icon(Icons.add),
    );
  }
}

////////////////////////////////// Custom Classes ///////////////////////////////////////


// TimePicker textfield card
class TimePickerTextField extends StatefulWidget {
  final double _textFieldWidth;
  final Item _item;
  final bool _isEditing;
  /// Returns a funtion with the Item 
  /// of the item to open the picker view witht the correct data.
  final Function(Item) _onItemTextPressed;

  TimePickerTextField(this._item, this._onItemTextPressed, this._textFieldWidth, this._isEditing);

  _TimePickerTextFieldState createState() => _TimePickerTextFieldState();
}
class _TimePickerTextFieldState extends State<TimePickerTextField> {

  TextEditingController _controller;
  FocusNode _focus;
  Item _item;


      @override
       void initState() {
            _item = widget._item;
            _focus = new FocusNode();
            _focus.addListener(handleLeftProfileTextfieldFocus);
            _controller = new TextEditingController(text: Functions.convertSecsToMinsAndSec(Functions.getIntValue(_item.value)));
            super.initState();
      }

      @override
      void dispose() {
        _controller.dispose();
        super.dispose();
      }

      void handleLeftProfileTextfieldFocus(){
        if (_focus.hasFocus){setState(() {
            widget._onItemTextPressed(widget._item);
        });
          _focus.unfocus();  
        }
      }

      @override
      void didUpdateWidget(TimePickerTextField oldWidget) {
        _controller.text = Functions.convertSecsToMinsAndSec(Functions.getIntValue(_item.value));
          super.didUpdateWidget(oldWidget);
        }      

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(padding: EdgeInsets.all(10.0), child: TextFormField(
          enabled: widget._isEditing,
           textAlign: TextAlign.start,
           decoration: new InputDecoration(
             prefixIcon: Icon(Icons.timer),
             labelText: widget._item.title,
           ),
           focusNode: _focus,
           controller: _controller,
       )));
  }
}


//Picker textfield card
class PickerTextField extends StatefulWidget {
  final double _textFieldWidth;
  final Item _item;
  final bool _isEditing;
  /// Returns a funtion with the Item 
  /// of the item to open the picker view witht the correct data.
  final Function(Item) _onItemTextPressed;

  PickerTextField(this._item, this._onItemTextPressed, this._textFieldWidth, this._isEditing);

  _PickerTextFieldState createState() => _PickerTextFieldState();
}
class _PickerTextFieldState extends State<PickerTextField> {

  TextEditingController _controller;
  FocusNode _focus;

      @override
       void initState() {
            _focus = new FocusNode();
            _focus.addListener(handleLeftProfileTextfieldFocus);
            _controller = new TextEditingController(text: widget._item.value);
            super.initState();
      }

      @override
      void dispose() {
        _controller.dispose();
        super.dispose();
      }

      void handleLeftProfileTextfieldFocus(){
        if (_focus.hasFocus){setState(() {
            widget._onItemTextPressed(widget._item);
        });
          _focus.unfocus();  
        }
      }

      @override
      void didChangeDependencies() {
        _controller.text = widget._item.value;
        super.didChangeDependencies();
      }

  @override
  Widget build(BuildContext context) {
     _controller.text = widget._item.value;
    return Expanded(
      flex: 5,
      child: Container(padding: EdgeInsets.all(10.0), child: TextFormField(
          enabled: widget._isEditing,
           textAlign: TextAlign.start,
           decoration: new InputDecoration(
             prefixIcon: widget._item.icon ?? null,
             labelText: widget._item.title,
           ),
           focusNode: _focus,
           controller: _controller,
       )));
  }
}

/// Tab View Data
class TabViewData{

  Widget screen;
  ProfileType type;
  Tab tab;
  
  TabViewData(this.screen, this.tab, this.type);

}

/// TabViewDataArray
class TabViewDataArray{

  List<TabViewData> ref;

 TabViewDataArray(this.ref);
}

/// Popups

class PopUps{
///
/// Show alert
///
static void showCircularProgressIndicator(BuildContext context){
showDialog(barrierDismissible: false, context: context ,
        builder: (context) =>  Center(child:CircularProgressIndicator()));
}

static Future<void> showAlert
(String title, String message, String buttonText, Function buttonFunction, BuildContext context) async {

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(buttonText),
            onPressed: buttonFunction ??
                           Navigator.of(context).pop()
          )
        ],
      );
    },
  );
  }


 static Future<void> yesOrNoDioLog(BuildContext context,String title, String message, Function returnYes) async {

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () => returnYes(true)
          ),

          FlatButton(
            child: Text('No'),
            onPressed: () => returnYes(false)
          )
        ],
      );
    },
  );
}
}

class ProfileImage extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 120.0;
  final double _cornerRadius = 20.0;
  final Image _image;

  ProfileImage(this._image);

  @override
  Widget build(BuildContext context) {
    return

        /// Profile Image
        Container(
            margin: EdgeInsets.all(_margin),
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 1.0, // has the effect of softening the shadow
                spreadRadius: 1.0, // has the effect of extending the shadow
                offset: Offset(
                  1.0, // horizontal, move right 10
                  1.0, // vertical, move down 10
                ),
              )
            ], borderRadius: BorderRadius.circular(_cornerRadius)),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(_cornerRadius)),
                child: Image.asset(
                  Images.cherries,
                  fit: BoxFit.cover,
                )));
  }
}

/// Date input card
class DateInputCard extends StatefulWidget {
  final double _padding = 5.0;
  final _dateFormat = DateFormat.yMd();
  final DateTime _dateTime;
  final Function(DateTime) onDateChanged; 
  final String _title;
  final bool _isEditing;

  DateInputCard(this._title, this._dateTime, this.onDateChanged, this._isEditing);

  _DateInputCardState createState() => new _DateInputCardState();
}
class _DateInputCardState extends State<DateInputCard> {
  
  TextEditingController _controller = new TextEditingController();
  FocusNode _focus = new FocusNode();
  DateTime _dateTime;


  @override
    void initState() {
      _controller.text = widget._dateFormat.format(widget._dateTime);
      _focus = new FocusNode();
      _focus.addListener(handleTextfieldFocus);
      _dateTime = widget._dateTime;
      super.initState();
    }

   void handleTextfieldFocus()async{
    if (_focus.hasFocus){
      DateTime date = await getDateTimeInput(context, widget._dateTime, TimeOfDay.now());
      setState(() {
        widget.onDateChanged(date);
        _dateTime = date;        
        _focus.unfocus(); 
      });
    }
  }

  Future<DateTime> getDateTimeInput(
      BuildContext context, DateTime initialDate, TimeOfDay initialTime) async {
    var date = await showDatePicker(
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        context: context,
        initialDate: initialDate,);
    return date;
  }    
    
   
  @override
  Widget build(BuildContext context) {
     _controller.text = widget._dateFormat.format(_dateTime);
    return 
    Expanded(
      flex: 5,
      child:Container( 
        margin:  EdgeInsets.all(widget._padding),
        padding: EdgeInsets.all(widget._padding),
        child:  TextFormField
          (enabled: widget._isEditing,
            controller: _controller,
          focusNode: _focus,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range),
              labelText: widget._title),
          ),
          ),      
    );
  }
}

/// Date input card
class DateTimeInputCard extends StatefulWidget {
  final double _padding = 10.0;
  final double _margin = 10.0;
  final _dateFormat = DateFormat("MMMM d, yyyy 'at' h:mma");
  final DateTime _dateTime;
  final Function(DateTime) onDateChanged; 
  final String _title;
  final bool _isEditing;

  DateTimeInputCard(this._title, this._dateTime, this.onDateChanged, this._isEditing);

  _DateTimeInputCardState createState() => new _DateTimeInputCardState();
}
class _DateTimeInputCardState extends State<DateTimeInputCard> {
  
  TextEditingController _controller = new TextEditingController();
  FocusNode _focus = new FocusNode();

  @override
    void initState() {
      _controller.text = widget._dateFormat.format(widget._dateTime);
      _focus = new FocusNode();
      _focus.addListener(handleTextfieldFocus);
      super.initState();
    }

  @override
    void didUpdateWidget(DateTimeInputCard oldWidget) {
      _controller.text = widget._dateFormat.format(widget._dateTime);
      super.didUpdateWidget(oldWidget);
    }

    void handleTextfieldFocus()async{
        if (_focus.hasFocus){
        DateTime date = await getDateTimeInput(context, widget._dateTime, TimeOfDay.fromDateTime(widget._dateTime));
        setState(() {
          if(date != null){
            _controller.text = widget._dateFormat.format(date);
            widget.onDateChanged(date);
                      _focus.unfocus();
          } 
        });
      }
    }

    Future<DateTime> getDateTimeInput(
      BuildContext context, DateTime initialDate, TimeOfDay initialTime) async {
        var date = await showDatePicker(
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            context: context,
            initialDate: initialDate,);
        if (date != null) {
          date = startOfDay(date);
            final time = await showTimePicker(
              context: context,
              initialTime: initialTime ?? TimeOfDay.now(),
            );
            if (time != null) {
              date = date.add(Duration(hours: time.hour, minutes: time.minute));
            }
        }
        return date;
      }    
    
  @override
  Widget build(BuildContext context) {
    return Card(child: Container(
        padding: EdgeInsets.all(widget._padding),
        margin: EdgeInsets.all(widget._margin),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextFormField
                    (enabled: widget._isEditing,
                      controller: _controller,
                      focusNode: _focus,
                      decoration: InputDecoration(
                        icon: Icon(Icons.date_range),
                        labelText: widget._title),
                    ),
                    ),
                ],
              ),
            ])),
      );
  }
}

///TextField Value input
class TextFieldWithInitalValue extends StatefulWidget {
final _textFieldWidth;
final Function(dynamic) _giveValue;
final dynamic _initalValue; 
final String _titleLabel;
final String _hintText;
final TextInputType _inputType;
final bool _isEditing;

TextFieldWithInitalValue
(this._inputType,this._titleLabel, this._hintText, this._initalValue, this._giveValue, this._textFieldWidth, this._isEditing);

  _TextFieldWithInitalValueState createState() => _TextFieldWithInitalValueState();
}
class _TextFieldWithInitalValueState extends State<TextFieldWithInitalValue> {

TextEditingController _controller;

  @override
    void initState() {
        _controller = new TextEditingController(text: widget._initalValue.toString());
      super.initState();
    }
@override
  Widget build(BuildContext context) {
    return
    Container(
        width: widget._textFieldWidth,
        child: TextField(
        enabled: widget._isEditing,
        controller: _controller ,
        textAlign: TextAlign.start,
        keyboardType: widget._inputType,
        decoration: new InputDecoration(
        labelText: widget._titleLabel,
        hintText: widget._hintText,),
          onChanged: widget._giveValue,
        )
    )
    ; 
  }
}       

///TextField Item input
class TextFieldItemWithInitalValue extends StatefulWidget {

final double _textFieldWidth;
final Function(dynamic) _giveValue;
final Item _item;
final bool _isEditing;
final List<TextInputFormatter> textInputFormatters;
final TextAlign textAlign;


TextFieldItemWithInitalValue
(this._item, this._giveValue, this._textFieldWidth, this._isEditing,{this.textInputFormatters, this.textAlign = TextAlign.start,});

 _TextFieldItemWithInitialValueState createState() => _TextFieldItemWithInitialValueState();
}
class _TextFieldItemWithInitialValueState extends State<TextFieldItemWithInitalValue> {

  TextEditingController _controller;

  @override
    void initState() {
      _controller = new TextEditingController(text: widget._item.value);
    super.initState();
    }


  @override
  Widget build(BuildContext context) {
    return
    Expanded(
      flex: 5,
      child: Container(padding: EdgeInsets.all(5.0), margin: EdgeInsets.all(5.0), 
        child: TextField(
          
          autofocus: false,
          inputFormatters: widget.textInputFormatters ?? <TextInputFormatter>[],
          enabled: widget._isEditing,
          controller: _controller ,
          textAlign: widget.textAlign,
          keyboardType: widget._item.keyboardType,
          decoration: 
            new InputDecoration(
            prefixIcon: widget._item.icon ?? null,
            labelText: widget._item.title,
            hintText: widget._item.placeHolderText,
              ),
              onChanged: (value) => setState( () {
                if (
                        widget._item.databaseId == DatabaseIds.brewingDose ||
                        widget._item.databaseId == DatabaseIds.yielde ||
                        widget._item.databaseId == DatabaseIds.brewWeight){
                          widget._giveValue(value.split('').reversed.join());
                }else{ widget._giveValue(value);}}),
            )
          )); 
        }
}       

///TextField Item input
class TextFieldSpanItemWithInitalValue extends StatefulWidget {

final Function(dynamic) _giveValue;
final Item _item;

TextFieldSpanItemWithInitalValue(this._item, this._giveValue,);

 _TextFieldSpanItemWithInitalValueState createState() => _TextFieldSpanItemWithInitalValueState();
}
class _TextFieldSpanItemWithInitalValueState extends State<TextFieldSpanItemWithInitalValue> {



TextEditingController _controller;

@override
  void initState() {
      _controller = new TextEditingController(text: widget._item.value);
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    return
Container(
   child: TextField(
   controller: _controller ,
   textAlign: TextAlign.start,
   keyboardType: widget._item.keyboardType,
   decoration: new InputDecoration(
   labelText: widget._item.title,
   hintText: widget._item.placeHolderText,
             ),
             onChanged: widget._giveValue,
           )
           ); 
  }
}       

///TextfieldWithFixedValue
class TextfieldWithFixedValue extends StatefulWidget {

final dynamic _initalValue; 
final String _titleLabel;
final double width;

TextfieldWithFixedValue(this._titleLabel, this._initalValue,{this.width});

 _TextfieldWithFixedValueState createState() => _TextfieldWithFixedValueState();
}
class _TextfieldWithFixedValueState extends State<TextfieldWithFixedValue> {
  
  TextEditingController _controller = new TextEditingController();

  @override
  void didUpdateWidget(TextfieldWithFixedValue oldWidget) {
      _controller.text = widget._initalValue.toString();
      super.didUpdateWidget(oldWidget);
    }

  @override
  Widget build(BuildContext context) {
    return
    
    Container(
        width: widget.width ?? 100.0,
        child: TextFormField(
        controller: _controller ,
        enabled: false,
        textAlign: TextAlign.center,
        decoration: new InputDecoration(
          labelText: widget._titleLabel, 
          labelStyle: TextStyle(fontSize: 10.0)
        ),
      )
    ); 
  }
}   

/// Follow  button
class FollowButton extends StatefulWidget {
  
  final String userId;

  FollowButton(this.userId);

  _FollowButtonState createState() => _FollowButtonState();
}
class _FollowButtonState extends State<FollowButton> {

  bool _initialised = false;

  void initState() { 
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    if (!_initialised){
    _initialised = false;}

    return  
   
     ScopedModelDescendant<ProfilesModel>
            (rebuildOnChange: true, builder: (context, _ ,model) =>

        StreamBuilder<UserProfile>(
          stream:  model.userProfileStream,
          builder: (BuildContext context, AsyncSnapshot<UserProfile> snapshot) =>

          RaisedButton(
            color: model.isUserFollowing(widget.userId) ? Colors.black : Theme.of(context).accentColor,
            shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
            onPressed: () {
                ProfilesModel.of(context).followOrUnfollow(widget.userId, ((isFollowing){ }) );
            },
              
          child: ScalableWidget( 
            Text( model.isUserFollowing(widget.userId) ? 
              StringLabels.unFollow :
              StringLabels.follow,
              style: TextStyle(
                fontWeight: model.isUserFollowing(widget.userId) ? FontWeight.w600:FontWeight.w600,
                color: model.isUserFollowing(widget.userId) ? Theme.of(context).accentColor : Colors.black,),),
              )),
      )
    );
  }
}

class FeedRefresher extends StatelessWidget {

  final RefreshController _refreshController = new RefreshController();
  final Widget _child;
  final FeedType _feedtype;
  
  FeedRefresher(this._child, this._feedtype);

  void _onRefresh(bool up, ProfilesModel model)async{
		if(up){
		   //headerIndicator callback
		   model.getSocialFeed(_feedtype); 
       new Future.delayed(const Duration(seconds: 2))
                               .then((val) {
                                 _refreshController.sendBack(true, RefreshStatus.completed);
                           }); 
		}else{
			//footerIndicator Callback
		}
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<ProfilesModel>
      (builder: (BuildContext context, _ ,ProfilesModel model) =>

      SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: (up) => _onRefresh(up, model),
        child:_child,
      )
    );
  }
}

class ProfileRefresher extends StatelessWidget {

  final RefreshController _refreshController = new RefreshController();
  final Widget _child;
  
  ProfileRefresher(this._child);

  void _onRefresh(bool up)async{
		if(up){
		   //headerIndicator callback
       new Future.delayed(const Duration(seconds: 2))
                               .then((val) {
                                 _refreshController.sendBack(true, RefreshStatus.completed);
                           }); 
		}else{
			//footerIndicator Callback
		}
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<ProfilesModel>
      (builder: (BuildContext context, _ ,ProfilesModel model) =>

      SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: (up) => _onRefresh(up),
        child:_child,
      )
    );
  }
}

class CupertinoImagePickerDiolog extends StatelessWidget {

  final ImageSource _imageSource; 
  final Function(dynamic) _setimage;

  CupertinoImagePickerDiolog(this._imageSource, this._setimage);

  void showImagePicker(BuildContext context){
      ImagePicker.pickImage(maxWidth: 640.0, maxHeight: 480.0, source: _imageSource)
                  .then((image) => handleImagePickerReturn(image, context))
                  .catchError((error) => print(error));
  }

  void handleImagePickerReturn(dynamic image, context){
    if(image != null){
      /// If image is not null Image is a file
      PopUps.showCircularProgressIndicator(context);
      sendBackFilePath((image as File).path, context);

      // DatabaseFunctions.upLoadFileReturnUrl(image, [DatabaseIds.image])
      //                                     .then((url) => sendBackUrl(url, context))
      //                                     .catchError((error){print(error);});
    }
  }

  void sendBackFilePath(String filePath, BuildContext context){
      assert(filePath != null);
      if(filePath != null){_setimage(filePath);
      /// Remove circular progrss indicator
      Navigator.pop(context, filePath);}  
  }

  void sendBackUrl(String url, BuildContext context){
      assert(url != null);
      if(url != null){_setimage(url);
      /// Remove circular progrss indicator
      Navigator.pop(context, url);}  
  }


  @override
  Widget build(BuildContext context){

    String _title = '';

    if(_imageSource == ImageSource.camera){ _title = StringLabels.camera;}
    else{ _title = StringLabels.photoLibrary;}

    return CupertinoDialogAction(
          child: Text(_title, style: Theme.of(context).textTheme.display1),
          isDestructiveAction: false,
          onPressed: () => showImagePicker(context)
    );
  }
}

class CopyProfileButton extends StatelessWidget {

  final Profile _profile;

  CopyProfileButton(this._profile);

  @override
  Widget build(BuildContext context) {
    return 
    RawMaterialButton(
      child: Icon(Icons.content_copy),
      onPressed: ()async{  

        Profile _newProfile
          = Profile(
            likes:  _profile.likes,
            comments: _profile.comments,
            userId: _profile.userId,
            updatedAt: DateTime.now(),
            objectId: '',
            type: _profile.type,
            properties: _profile.properties,
            databaseId: _profile.databaseId,
            orderNumber: _profile.orderNumber,
            profiles: _profile.profiles,
          );

        
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
        ProfilePage(
          isFromUserFeed: false,
          isOldProfile: false,
          isCopying: true, 
          isEditing: true, 
          isNew: true, 
          type: _profile.type, 
          referance: '',
          profile: _newProfile ,)
          )
          ).then((_) => Navigator.pop(context)
        );
      }
    );
  }
}

class DeleteProfileButton extends StatelessWidget {

  final Profile _profile;

  DeleteProfileButton(this._profile);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
                    child: Icon(Icons.delete),
                    onPressed: ()async{ ProfilesModel.of(context).delete(_profile);
                      Navigator.pop(context);
                    }
    );        
  }
}




