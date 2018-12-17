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
import 'dart:io';
import 'package:dial_in_v1/data/mini_classes.dart';

/// Background
class Pagebackground extends StatelessWidget {
  final AssetImage _image;

  Pagebackground(this._image);

  @override
  Widget build(BuildContext context) {
    return

        /// Background
        new Container(
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
  final TextEditingController _controller;
  final bool _obscureText;


  TextFieldEntry(this._placeholder, this._controller, this._obscureText);

  @override
  State<StatefulWidget> createState() {

    return _TextFieldEntryState();
  }
}

/// Textfield Entry
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
                fillColor: Colors.grey.withOpacity(0.7))));
  }
}

class CircularPicture extends StatelessWidget {
  final File _image;
  final double _size;

  CircularPicture(this._image, this._size);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(_size),
          child: Image.file(_image, fit: BoxFit.cover),),
          height: _size,
          width: _size,);
          
  }
}

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
      onPressed: () {_buttonAction;},
    );
  }
}

/// Custom page transitions
class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}

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
                  child: CircularPicture(File('assets/images/user.png'), 100.0))),

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
class ProfileCard extends StatelessWidget {
  
  final Function(Profile) _giveprofile;
  final Profile profile;
  String _topLeft = 'error';
  String _topRight = 'error';
  String _bottomRight = 'error';
  String _bottomleft = 'error';
  final _dateFormat = DateFormat.yMd();

  ProfileCard(this.profile, this._giveprofile,){

    switch(profile.type){
      
      case ProfileType.recipe: 
      _topLeft = profile.getProfileProfileTitleValue(profileDatabaseId: DatabaseIds.coffee);
      _topRight = _dateFormat.format(profile.getProfileItemValue(DatabaseIds.date));
      _bottomRight = profile.getProfileProfileTitleValue(profileDatabaseId: DatabaseIds.brewingEquipment);
      _bottomleft = profile.getProfileProfileTitleValue(profileDatabaseId: DatabaseIds.score);
      break;

      case ProfileType.coffee:  
      _topLeft = profile.getProfileItemValue( DatabaseIds.coffeeId);
      _topRight = profile.getProfileItemValue( DatabaseIds.processingMethod);
      _bottomRight = _dateFormat.format(profile.getProfileItemValue(DatabaseIds.roastDate));
      _bottomleft = profile.getProfileItemValue( DatabaseIds.country);
      break;

      case ProfileType.water:   
      _topLeft = profile.getProfileItemValue( DatabaseIds.waterID);
      _topRight = profile.getProfileItemValue( DatabaseIds.ppm);
      _bottomRight = profile.getProfileItemValue( DatabaseIds.kh);
      _bottomleft = profile.getProfileItemValue( DatabaseIds.gh);
      break;

      case ProfileType.equipment:   
      _topLeft = profile.getProfileItemValue( DatabaseIds.equipmentId);
      _topRight = profile.getProfileItemValue( DatabaseIds.type);
      _bottomRight = profile.getProfileItemValue( DatabaseIds.method);
      _bottomleft = profile.getProfileItemValue( DatabaseIds.equipmentModel); 
      break;

      case ProfileType.grinder:   
      _topLeft = profile.getProfileItemValue( DatabaseIds.grinderId);
      _topRight = profile.getProfileItemValue( DatabaseIds.burrs);
      _bottomRight = profile.getProfileItemValue( DatabaseIds.grinderMake);
      _bottomleft = profile.getProfileItemValue( DatabaseIds.grinderModel);      
      break;

      case ProfileType.barista:   
      _topLeft = profile.getProfileItemValue( DatabaseIds.name);
      _topRight = profile.getProfileItemValue( DatabaseIds.level);
      _bottomleft = profile.getProfileItemValue( DatabaseIds.notes);
      _bottomRight = profile.getProfileItemValue( DatabaseIds.age);       
      break;

      case ProfileType.none:  
      _topLeft = 'error none';
      _topRight = 'error none';
      _bottomRight = 'error none';
      _bottomleft = 'error none';       
      break;  

      case ProfileType.feed:   
      _topLeft = 'error feed';
      _topRight = 'error feed';
      _bottomRight = 'error feed';
      _bottomleft = 'error feed';       
      break;  

      default: 
      _topLeft = 'error default';
      _topRight = 'error default';
      _bottomRight = 'error default';
      _bottomleft = 'error default';              
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    Dismissible(
    // Each Dismissible must contain a Key. Keys allow Flutter to
    // uniquely identify Widgets.
    background: Container(color: Colors.red),
    key: Key(profile.objectId),
    // We also need to provide a function that will tell our app
    // what to do after an item has been swiped away.
    onDismissed: (direction) {
      // Remove the item from our data source.
      DatabaseFunctions.deleteProfile(this.profile);

    // Show a snackbar! This snackbar could also contain "Undo" actions.
    Scaffold
        .of(context)
        .showSnackBar(SnackBar(content: Text("Profile deleted")));
  },
  child: 
    Card(child: 
      InkWell(onTap:() => _giveprofile(profile)
       
      ,child: 
        
      Row(children: <Widget>[
      ///
      /// Profile picture
      ///
      Hero(tag: profile.objectId , child: Container(
          child: CircularPicture(profile.image, 60.0)),),
          

      Expanded(
          child: Row(children: <Widget>[
        ///
        /// Main name and secondnary details
        ///
        Expanded(
            child: Container(
                padding: EdgeInsets.all(0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(10.0), child: Text(_topLeft, overflow: TextOverflow.clip, style: Theme.of(context).textTheme.display1,)),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text(_bottomleft),
                      )
                    ]))),

        ///
        /// Third and fourth details
        ///
        Expanded(
            child: Container(
                padding: EdgeInsets.all(0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(10.0), child: Text(_topRight)),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text(_bottomRight),
                      )
                    ])))
      ]))
    ]),
    ))
  );
  }
}

///Social card
class SocialProfileCard extends StatelessWidget {

  final Function(Profile) _giveprofile;
  final FeedProfileData _profile;
  final _dateFormat = DateFormat.yMd();

  SocialProfileCard(this._profile, this._giveprofile,);

  
  @override
  Widget build(BuildContext context) {
    return 
    Card(child: 
      InkWell(onTap:() => _giveprofile(_profile.profile)
       
      ,child: 

      Column(children: <Widget>[
        
       Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[


      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
      
          /// User picture
          Container(
              child: CircularPicture(_profile.userImage , 60.0)),
              ]),
      
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            ///User Name
            Text(_profile.userId, style: Theme.of(context).textTheme.display1,),

        ]),
        Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [ 
      
          Container(margin: const EdgeInsets.all(15.0) ,child:RaisedButton(child: Text('Follow'),onPressed: (){},),),
          ]) ,)
            
  
      ],),      

      /// Recipe picture
      Hero(tag: _profile.profile.objectId, child: SizedBox(width: double.infinity, height: 200.0, child:
        Image.file(_profile.profile.image, fit: BoxFit.cover,),),),

       /// Coffee Name
        Text(_profile.profile.getProfileProfileItemValue(ProfileType.coffee, DatabaseIds.coffeeId), style: Theme.of(context).textTheme.display1,),

        /// Brew method
        Text(_profile.profile.getProfileProfileItemValue(ProfileType.equipment, DatabaseIds.equipmentId)), 

        /// Notes
        Text(_profile.profile.getProfileProfileItemValue(ProfileType.equipment, DatabaseIds.descriptors)), 

        ///Score
        new StarRating(
                size: 25.0,
                rating: 2.5,
                color: Colors.orange,
                borderColor: Colors.grey,
                starCount: 5,
              ),        
      ]),
      ),
    );
  }
}


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
              fontSize: 20.0),
        ));
  }
}

///
/// Add floating action button
///

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


/// Tab View Data
class TabViewData{

  Widget screen;
  ProfileType type;
  Tab tab;
  
  TabViewData(this.screen, this.tab, this.type);

}

class TabViewDataArray{

  List<TabViewData> ref;

 TabViewDataArray(this.ref);
}

class PopUps{
///
/// Show alert
/// 

static Future<void> showAlert({String title, String message, String buttonText, Function buttonFunction, BuildContext context }) async {
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
            onPressed: () {
              buttonFunction();
              // Navigator.of(context).pop();
            },
          ),
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

class DateInputCard extends StatefulWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  final _dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final DateTime _dateTime;
  Function(DateTime) onDateChanged; 
  String _title;

  DateInputCard(this._title, this._dateTime, this.onDateChanged);

  _DateInputCardState createState() => new _DateInputCardState();
}

class _DateInputCardState extends State<DateInputCard> {
  DateTime _dateTime;

  @override
    void didUpdateWidget(Widget oldWidget) {
      
       _dateTime = widget._dateTime;
      super.didUpdateWidget(oldWidget);
    }
    
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(widget._margin),
      child: Container(
        padding: EdgeInsets.all(widget._padding),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: DateTimePickerFormField(
                      format: widget._dateFormat,
                      initialDate: widget._dateTime,
                      decoration: InputDecoration(labelText: widget._title),
                      onChanged: widget.onDateChanged),
                    ),
                ],
              ),
            ]),
      ),
    );
  }
}

/// Widgets
class TextFieldWithInitalValue extends StatelessWidget {

final double _textFieldWidth = 150.0;
TextEditingController _controller;
final Function(dynamic) _giveValue;
final dynamic _initalValue; 
final String _titleLabel;
final String _hintText;
final TextInputType _inputType;

TextFieldWithInitalValue
(this._inputType,this._titleLabel, this._hintText, this._initalValue, this._giveValue)
{_controller = new TextEditingController(text: _initalValue.toString());}

@override
  Widget build(BuildContext context) {
    return
    Container(
      width: _textFieldWidth,
        child: TextField(
        controller: _controller ,
        textAlign: TextAlign.start,
        keyboardType: _inputType,
        decoration: new InputDecoration(
        labelText: _titleLabel,
        hintText: _hintText,),
          onChanged: _giveValue,
        )
    ); 
  }
}       

class TextFieldItemWithInitalValue extends StatelessWidget {

final double _textFieldWidth = 150.0;
TextEditingController _controller;
final Function(dynamic) _giveValue;
final Item item;

TextFieldItemWithInitalValue
(this.item, this._giveValue)
{_controller = new TextEditingController(text: item.value);}

@override
  Widget build(BuildContext context) {
    return
Container(
  width: _textFieldWidth,
   child: TextField(
   controller: _controller ,
   textAlign: TextAlign.start,
   keyboardType: item.keyboardType,
   decoration: new InputDecoration(
   labelText: item.title,
   hintText: item.placeHolderText,
             ),
             onChanged: _giveValue,
           )
           ); 
  }
}       

class TextFieldWithFixedValue extends StatelessWidget {

final dynamic _initalValue; 
final String _titleLabel;

TextFieldWithFixedValue(this._titleLabel, this._initalValue,);

@override
  Widget build(BuildContext context) {
    return
    Expanded(
        child: TextFormField(
        initialValue: _initalValue,
        enabled: false,
        textAlign: TextAlign.start,
        decoration: new InputDecoration(
        labelText: _titleLabel,
        
        ),
        )
    ); 
  }
}   


