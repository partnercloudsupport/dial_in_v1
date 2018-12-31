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
                fillColor: Colors.grey.withOpacity(0.7))));
  }
}

/// Circular picture
class CircularPicture extends StatelessWidget {
  final String _image;
  final double _size;

  CircularPicture(this._image, this._size);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow
          (color: Colors.black87, offset: new Offset(0.0, 2.0),blurRadius: 2.0,)],
          shape: BoxShape.circle
        ),
        height:_size,
        width: _size,
        margin: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(_size),
          child: 
          
          FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: Images.rippleLoadingGif,
            image: _image
             )),
          
          // Image.network(_image, fit: BoxFit.cover),),
          );   
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
                  child: CircularPicture('assets/images/user.png', 100.0))),

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
  final Function(Profile) _deleteProfile;
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
      _topRight = widget._dateFormat.format(widget._profile.getProfileItemValue(DatabaseIds.date));
      _bottomRight = widget._profile.getProfileProfileTitleValue(profileDatabaseId: DatabaseIds.brewingEquipment);
      _bottomleft = 'widget._profile.getTotalScore()';
      _score = widget._profile.getTotalScore();
      break;

      case ProfileType.coffee:  
      _topLeft = widget._profile.getProfileItemValue( DatabaseIds.coffeeId);
      _topRight = widget._profile.getProfileItemValue( DatabaseIds.processingMethod);
      _bottomRight = widget._dateFormat.format(widget._profile.getProfileItemValue(DatabaseIds.roastDate));
      _bottomleft = widget._profile.getProfileItemValue( DatabaseIds.country);
      break;

      case ProfileType.water:   
      _topLeft = widget._profile.getProfileItemValue( DatabaseIds.waterID);
      _topRight = widget._profile.getProfileItemValue( DatabaseIds.ppm);
      _bottomRight = widget._profile.getProfileItemValue( DatabaseIds.kh);
      _bottomleft = widget._profile.getProfileItemValue( DatabaseIds.gh);
      break;

      case ProfileType.equipment:   
      _topLeft = widget._profile.getProfileItemValue( DatabaseIds.equipmentId);
      _topRight = widget._profile.getProfileItemValue( DatabaseIds.type);
      _bottomRight = widget._profile.getProfileItemValue( DatabaseIds.method);
      _bottomleft = widget._profile.getProfileItemValue( DatabaseIds.equipmentModel); 
      break;

      case ProfileType.grinder:   
      _topLeft = widget._profile.getProfileItemValue( DatabaseIds.grinderId);
      _topRight = widget._profile.getProfileItemValue( DatabaseIds.burrs);
      _bottomRight = widget._profile.getProfileItemValue( DatabaseIds.grinderMake);
      _bottomleft = widget._profile.getProfileItemValue( DatabaseIds.grinderModel);      
      break;

      case ProfileType.barista:   
      _topLeft = widget._profile.getProfileItemValue( DatabaseIds.name);
      _topRight = widget._profile.getProfileItemValue( DatabaseIds.level);
      _bottomleft = widget._profile.getProfileItemValue( DatabaseIds.notes);
      _bottomRight = widget._profile.getProfileItemValue( DatabaseIds.age);       
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
    key: Key(widget._profile.objectId),
    // We also need to provide a function that will tell our app
    // what to do after an item has been swiped away.
    onDismissed: (direction) {
      // Remove the item from our data source.
      widget._deleteProfile(widget._profile);

    // Show a snackbar! This snackbar could also contain "Undo" actions.
    Scaffold
        .of(context)
        .showSnackBar(SnackBar(content: Text("Profile deleted")));
  },
  child: 
    Card(child: Container(padding: EdgeInsets.all(5.0),child:
      InkWell(onTap:() => widget._giveprofile(widget._profile)
       
      ,child: 
        
      Row(children: <Widget>[
      ///
      /// Profile picture
      ///
      Hero(tag: widget._profile.objectId , child: Container(
          child: CircularPicture(widget._profile.image, 60.0)),),
          
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
                          margin: EdgeInsets.all(10.0), child: Text(_topLeft, maxLines: 1,
                           overflow: TextOverflow.clip, style: Theme.of(context).textTheme.display1,)),
                      Container(
                        margin: EdgeInsets.all(10.0),
                              child: widget._profile.type == ProfileType.recipe ? 
                              ScalableWidget(FiveStarRating(widget._profile.getTotalScore().toInt()))  :
                              Text(_bottomleft, maxLines: 1)
                      )
                    ]
                )
            )
        ),

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
                          margin: EdgeInsets.all(10.0), child: Text(_topRight, maxLines: 1)),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text(_bottomRight, maxLines: 1),
                      )
                    ])))
      ]))
    ]),
    )))
  );
  }
}

  class ScalableWidget extends FittedBox{
     ScalableWidget(Widget child) : super(child: child, fit: BoxFit.scaleDown);
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
        
      Material (color: Theme.of(context).bottomAppBarColor, 
      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[


      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
      
          /// User picture
          Container(
              child: CircularPicture(_profile.userImage , 60.0)),
              ]),
      
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

            ///User Name
            Container(margin: EdgeInsets.all(5.0), child: Text(_profile.userName,  maxLines: 1, style: Theme.of(context).textTheme.display1,),),

            /// Date
            Container(margin: EdgeInsets.all(5.0), child: Text(_dateFormat.format(_profile.profile.getProfileItemValue(DatabaseIds.date)) ,  maxLines: 1), ),

        ]),
        Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [ 
      
          Container(margin: const EdgeInsets.all(15.0) ,child:RaisedButton(child: Text('Follow'),onPressed: (){},),),
          ]) ,)
            
      ],),),      

      /// Recipe picture
      Hero(tag: _profile.profile.objectId, child: SizedBox(width: double.infinity, height: 200.0, child:
        Material(type: MaterialType.card, elevation: 2.0 ,color: Theme.of(context).scaffoldBackgroundColor,
         child: FadeInImage.assetNetwork(image:_profile.profile.image, fit: BoxFit.cover, placeholder: Images.rippleLoadingGif),),),),
      
      ///Spacer
        Container(height: 20.0,),

       /// Coffee Name
        Container(margin: EdgeInsets.all(5.0), child: Text(_profile.profile.getProfileProfileItemValue(ProfileType.coffee, DatabaseIds.coffeeId),  maxLines: 1, style: Theme.of(context).textTheme.title,),),

        /// Notes
        Container(margin: EdgeInsets.all(5.0), child: Text(_profile.profile.getProfileItemValue(DatabaseIds.descriptors),  maxLines: 1), ),

        ///Score
        FiveStarRating(_profile.profile.getTotalScore().toInt())      
      ]),
      ),
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

//Picker textfield card
class PickerTextField extends StatefulWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth;
  final double _cornerRadius = 20.0;
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
             prefixIcon: Icon(Icons.tonality),
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
  final double _margin = 5.0;
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
      flex: 6,
      child:Container(
        padding: EdgeInsets.all(widget._padding),
        child:  TextFormField
          (enabled: widget._isEditing,
            controller: _controller,
          focusNode: _focus,
            decoration: InputDecoration(labelText: widget._title),
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
        widget.onDateChanged(date);
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

TextFieldItemWithInitalValue(this._item, this._giveValue, this._textFieldWidth, this._isEditing);

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
          ///TODO;
          // inputFormatters: [NumericTextFormatter()],
          enabled: widget._isEditing,
          controller: _controller ,
          textAlign: TextAlign.start,
          keyboardType: widget._item.keyboardType,
          decoration: 
            new InputDecoration(
            prefixIcon: Icon(Icons.face),
            labelText: widget._item.title,
            hintText: widget._item.placeHolderText,
              ),
              onChanged: widget._giveValue,
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

TextfieldWithFixedValue(this._titleLabel, this._initalValue,);

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
    ScalableWidget(
    Container(
        width: 100.0,
        child: TextFormField(
        controller: _controller ,
        enabled: false,
        textAlign: TextAlign.center,
        decoration: new InputDecoration(
        labelText: widget._titleLabel, 
        ),
      )
    )); 
  }
}   


