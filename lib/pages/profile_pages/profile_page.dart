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
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import '../overview_page/profile_list.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';



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
  Widget _backCancelButton;
  Widget _saveEditButton;
  Profile _profile;
  @required
  bool _isCopying;
  @required
  bool _isEditing;
  @required
  bool _isNew;

  void initState() {
    _isCopying = widget.isCopying;
    _isEditing = widget.isEditing;
    _isNew = widget.isNew;
    _profile = widget.profile;
    super.initState();
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

              /// Profile Image
              
              ProfileImage(Image.asset(Images.coffeeBeans)),

              FlatButton(
                onPressed: () {},
                child: Text(StringLabels.changeImage),
              ),


              DateInputCard(
                  _profile.getProfileItemValue(itemDatabaseId: DatabaseIds.date),
                  (dateTime){_profile = Functions.setProfileItemValue(
                    profile: _profile,
                    keyDatabaseId: DatabaseIds.date,
                    value: dateTime);}),


              /// Coffee and Barista Card

              DoubleProfileInputCard(
                leftHintText: StringLabels.selectCoffee,        
                leftImageRefString: Images.coffeeBeans,
                leftTextfieldText:  _profile.getProfileProfileTitleValue(profileDatabaseId: DatabaseIds.coffee),
                leftTitle: StringLabels.coffee,
                onLeftProfileTextPressed: (){_showDialog(DatabaseIds.coffee);},
                
                rightHintText: StringLabels.chooseBarista,
                rightImageRefString: Images.user,
                rightTextfieldText: _profile.getProfileProfileTitleValue(profileDatabaseId: DatabaseIds.Barista),
                rightTitle: StringLabels.barista ,
                onRightProfileTextPressed: (){_showDialog(DatabaseIds.Barista);} ), 
        

              ///Water Section
            
              ProfileInputCard(
                  imageRefString: Images.drop,
                  title: StringLabels.water,
                  keyboardType: TextInputType.number,
                  onAttributeTextChange: (text) {
                    _profile = Functions.setProfileItemValue(
                        profile: _profile,
                        keyDatabaseId: DatabaseIds.temparature,
                        value: text);
                  },
                  onProfileTextPressed: () {
                    _showDialog(DatabaseIds.water);
                  },
                  attributeTextfieldText: _profile.getProfileItemValue(
                      itemDatabaseId: DatabaseIds.temparature),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.temparature,
                  profileName: _profile.getProfileProfileTitleValue( profileDatabaseId: DatabaseIds.water)),

              /// Grinder

              ProfileInputCard(
                  imageRefString: Images.grinder,
                  title: StringLabels.grinder,
                  onAttributeTextChange: (text) {
                    _profile = Functions.setProfileItemValue(
                        profile: _profile,
                        keyDatabaseId: DatabaseIds.grindSetting,
                        value: text);
                  },
                  onProfileTextPressed: () {
                    _showDialog(DatabaseIds.grinder);
                  },
                  attributeTextfieldText: _profile.getProfileItemValue(
                      itemDatabaseId: DatabaseIds.grindSetting),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.setting,
                  keyboardType: TextInputType.number,
                  profileName: _profile.getProfileProfileTitleValue( profileDatabaseId: DatabaseIds.grinder)),


              /// Equipment
              ///
              ProfileInputCard(
                  imageRefString: Images.aeropressSmaller512x512,
                  title: StringLabels.brewingEquipment,
                  onAttributeTextChange: (text) {
                    _profile = Functions.setProfileItemValue(
                        profile: _profile,
                        keyDatabaseId: DatabaseIds.preinfusion,
                        value: text);
                  },
                  onProfileTextPressed: () {
                    _showDialog(DatabaseIds.brewingEquipment);
                  },
                  attributeTextfieldText: _profile.getProfileItemValue(
                      itemDatabaseId: DatabaseIds.preinfusion),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.preinfusion,
                  profileName: _profile.getProfileProfileTitleValue( profileDatabaseId: DatabaseIds.brewingEquipment)),

            /// Ratio card

            RatioCard(doseChanged: (dose) {
                _profile = Functions.setProfileItemValue(
                    profile: _profile,
                    keyDatabaseId: DatabaseIds.brewingDose,
                    value: _profile.getProfileItemValue(
                        itemDatabaseId: DatabaseIds.brewingDose));
              }, yieldChanged: ((yield) {
                _profile = Functions.setProfileItemValue(
                    profile: _profile,
                    keyDatabaseId: DatabaseIds.yield,
                    value: _profile.getProfileItemValue(
                        itemDatabaseId: DatabaseIds.yield));
              }), brewWeightChanged: (brewWeight) {
                _profile = Functions.setProfileItemValue(
                    profile: _profile,
                    keyDatabaseId: DatabaseIds.brewWeight,
                    value: _profile.getProfileItemValue(
                        itemDatabaseId: DatabaseIds.brewWeight));
              }),

              TwoTextfieldCard(
                titleLeft: StringLabels.time,
                leftHintText: StringLabels.setTime,
                titleRight: StringLabels.tds,
                rightHintText: StringLabels.enterValue,
                onLeftTextChanged: (text) {
                  Functions.setProfileItemValue(
                      profile: _profile,
                      keyDatabaseId: DatabaseIds.time,
                      value: _profile.getProfileItemValue(
                          itemDatabaseId: DatabaseIds.time));
                },
                onRightTextChanged: (text) {
                  Functions.setProfileItemValue(
                      profile: _profile,
                      keyDatabaseId: DatabaseIds.tds,
                      value: _profile.getProfileItemValue(
                          itemDatabaseId: DatabaseIds.tds));
                },
              ),

              NotesCard(
                  StringLabels.notes,
                  _profile.getProfileItemValue(
                      itemDatabaseId: DatabaseIds.notes),
                  (text) {Functions.setProfileItemValue(
                              profile: _profile,
                              keyDatabaseId: DatabaseIds.notes,
                              value: text);}),

              ///Score Section
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(_margin),
                      child: Text(
                        StringLabels.score,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        ScoreSlider(StringLabels.strength, 0.0, (value) {
                          Functions.setProfileItemValue(
                              profile: _profile,
                              keyDatabaseId: DatabaseIds.strength,
                              value: value);
                        }),

                        ScoreSlider(StringLabels.balance, 0.0, (value) {
                          Functions.setProfileItemValue(
                              profile: _profile,
                              keyDatabaseId: DatabaseIds.balance,
                              value: value);
                        }),

                        ScoreSlider(StringLabels.flavour, 0.0, (value) {
                          Functions.setProfileItemValue(
                              profile: _profile,
                              keyDatabaseId: DatabaseIds.flavour,
                              value: value);
                        }),

                        ScoreSlider(StringLabels.body, 0.0, (value) {
                          Functions.setProfileItemValue(
                              profile: _profile,
                              keyDatabaseId: DatabaseIds.body,
                              value: value);
                        }),

                        ScoreSlider(StringLabels.afterTaste, 0.0, (value) {
                          Functions.setProfileItemValue(
                              profile: _profile,
                              keyDatabaseId: DatabaseIds.afterTaste,
                              value: value);
                        }),

                        /// End of score
                        
                        NotesCard(
                        StringLabels.descriptors,
                        _profile.getProfileItemValue(
                            itemDatabaseId: DatabaseIds.descriptors),
                        (text) {Functions.setProfileItemValue(
                              profile: _profile,
                              keyDatabaseId: DatabaseIds.descriptors,
                              value: text);}), 
                        
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// End of Page
///

/// Widgets

class ScoreSlider extends StatefulWidget {
  final double _value;
  final String _label;
  final Function(double) _sliderValue;

  ScoreSlider(this._label, this._value, this._sliderValue);

  ScoreSliderState createState() => new ScoreSliderState();
}

class ScoreSliderState extends State<ScoreSlider> {
  double _value;
  String _label;
  double _margin = 10.0;

  @override
  void initState() {
    _value = widget._value;
    _label = widget._label;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(_margin),
            child: Text(widget._label),
          ),
          Slider(
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
              widget._sliderValue(value);
            },
            onChangeEnd: (value) {},
            onChangeStart: (value) {},
            min: 0,
            max: 10,
            divisions: 10,
            label: _value.toInt().toString(),
            activeColor: Theme.of(context).sliderTheme.inactiveTrackColor,
            inactiveColor: Theme.of(context).sliderTheme.inactiveTrackColor,
            
          )
        ]);
  }
}

////
/// Widgets
///
class ProfileInputCard extends StatefulWidget {

  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;

  final String imageRefString;
  final String title;
  final Function(String) onAttributeTextChange;
  final Function onProfileTextPressed;
  final String attributeTextfieldText;
  final String attributeHintText;
  final String profileHintText = StringLabels.chooseProfile;
  final String attributeTitle;
  final double _spacing = 5.0;
  final TextInputType keyboardType;
  final String profileName;
  

  ProfileInputCard(
      {this.imageRefString,
      this.title,
      this.onAttributeTextChange,
      this.onProfileTextPressed,
      this.attributeTextfieldText,
      this.attributeHintText,
      this.attributeTitle,
      this.keyboardType,
      this.profileName,
      });

      _ProfileInputCardState createState() => new _ProfileInputCardState();
}

class _ProfileInputCardState extends State<ProfileInputCard> {

      TextEditingController _attributeController;
      TextEditingController _profileTextController;
      FocusNode _textFocus;

      @override
       void initState() {
            _attributeController = new TextEditingController(text: widget.attributeTextfieldText);
            _attributeController.addListener(sendAttributeValue);
            _profileTextController = new TextEditingController(text: widget.profileName);
            _textFocus = new FocusNode();
            _textFocus.addListener(handleProfileTextfieldFocus);
            super.initState();
      }

      @override
      void dispose() {
        // Clean up the controller when the Widget is removed from the Widget tree
        _attributeController.dispose();
        _profileTextController.dispose();
        super.dispose();
      }

      void sendAttributeValue(){
        widget.onAttributeTextChange(_attributeController.text);
      }

      void handleProfileTextfieldFocus(){
        if (_textFocus.hasFocus){
        widget.onProfileTextPressed();
        _textFocus.unfocus();  
        }
      }

       @override
          void didUpdateWidget(Widget oldWidget) {
            _profileTextController = new TextEditingController(text: widget.profileName);
           super.didUpdateWidget(oldWidget);
      }


  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(widget._margin),
          child: Container(
            padding: EdgeInsets.all(widget._padding),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  /// Left profile selection
             
                       Container(
                            width: 40.0,
                            height: 40.0,
                            child: Image.asset(
                              widget.imageRefString,
                              fit: BoxFit.cover,
                            )),

                        Container(
                          width: widget._textFieldWidth,
                          child: TextFormField(
                              textAlign: TextAlign.end,
                              keyboardType: widget.keyboardType,
                              decoration: new InputDecoration(
                                labelText: widget.title,
                                hintText: StringLabels.selectProfile,
                              ),
                              focusNode: _textFocus,
                              controller: _profileTextController,)
                      ),

                        Container(
                            width: 120.0,
                            child: TextFormField(
                              textAlign: TextAlign.end,
                              keyboardType: widget.keyboardType,
                              decoration: new InputDecoration(
                                labelText: widget.attributeTitle,
                                hintText: widget.attributeHintText,
                              ),
                              controller: _attributeController,
                            ))
                      ]
            )));
            }
}

class DoubleProfileInputCard extends StatefulWidget {

  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  final double _spacing = 5.0; 

  final String leftImageRefString;
  final String leftTitle;
  final String leftTextfieldText;
  final String leftHintText;
  final Function onLeftProfileTextPressed;
  final String rightImageRefString;
  final String rightTitle;
  final String rightTextfieldText;
  final String rightHintText;
  final Function onRightProfileTextPressed;
 

  DoubleProfileInputCard({   
    @required this.leftImageRefString,
    @required this.leftTitle,
    @required this.leftTextfieldText,
    @required this.leftHintText,
    @required this.onLeftProfileTextPressed,

    @required this.rightImageRefString,
    @required this.rightTitle,
    @required this.rightTextfieldText,
    @required this.rightHintText,
    @required this.onRightProfileTextPressed,
    });

      _DoubleProfileInputCardState createState() => new _DoubleProfileInputCardState();
}

class _DoubleProfileInputCardState extends State<DoubleProfileInputCard> {

      TextEditingController _leftController;
       FocusNode _leftFocus;
     
      TextEditingController _rightController;
       FocusNode _rightFocus;

    
      @override
       void initState() {

            _leftFocus = new FocusNode();
            _leftFocus.addListener(handleLeftProfileTextfieldFocus);
            _rightFocus = new FocusNode();
            _rightFocus.addListener(handleRightProfileTextfieldFocus);

            super.initState();
      }

      @override
          void didUpdateWidget(Widget oldWidget) {
            _leftController = new TextEditingController(text: widget.leftTextfieldText);
            _rightController = new TextEditingController(text: widget.rightTextfieldText);
           super.didUpdateWidget(oldWidget);
          }

      @override
      void dispose() {
        // Clean up the controller when the Widget is removed from the Widget tree
        _leftController.dispose();
        _rightController.dispose();
        super.dispose();
      }


      void handleLeftProfileTextfieldFocus(){
        if (_leftFocus.hasFocus){
        widget.onLeftProfileTextPressed();
        _leftFocus.unfocus();  
        }
      }

      void handleRightProfileTextfieldFocus(){
        if (_rightFocus.hasFocus){
        widget.onRightProfileTextPressed();
        _rightFocus.unfocus();  
        }
      }


  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(widget._margin),
          child: Container(
            padding: EdgeInsets.all(widget._padding),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  /// Left profile selection
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Container(
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, widget._margin),
                            width: 40.0,
                            height: 40.0,
                            child: Image.asset(
                              widget.leftImageRefString,
                              fit: BoxFit.cover,
                            )),

                        Container(
                          width: widget._textFieldWidth,
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, widget._margin),
                          child: TextFormField(
                              textAlign: TextAlign.end,
                              decoration: new InputDecoration(
                                labelText: widget.leftTitle,
                                hintText: widget.leftHintText,
                              ),
                              focusNode: _leftFocus,
                              controller: _leftController,
                              )
                        ),
                 
                      ]),

                  /// Right
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Container(
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, widget._margin),
                            width: 40.0,
                            height: 40.0,
                            child: Image.asset(
                              widget.rightImageRefString,
                              fit: BoxFit.cover,
                            )),

                        Container(
                          width: widget._textFieldWidth,
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, widget._margin),
                          child: TextFormField(
                              textAlign: TextAlign.end,
                              decoration: new InputDecoration(
                                labelText: widget.rightTitle,
                                hintText: widget.rightHintText,
                              ),
                              focusNode: _rightFocus,
                              controller: _rightController,),
                        ),
                      ]),
                ])));
  }
}


/// User profile

class DateInputCard extends StatefulWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  final double _spacing = 15.0;
  final _dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final DateTime _dateTime;
  Function(DateTime) onDateChanged; 

  DateInputCard(this._dateTime,this.onDateChanged);

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
                      decoration: InputDecoration(labelText: 'Date'),
                      onChanged: widget.onDateChanged),
                    ),
                ],
              ),
            ]),
      ),
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

class CoffeeCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 120.0;
  final double _cornerRadius = 20.0;
  final Function _openOptions;
  final String coffee;

  CoffeeCard(this._openOptions, this.coffee);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(_margin),
      padding: EdgeInsets.all(_margin),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(width: 10.0, height: 10.0),
            RawMaterialButton(
              onPressed: _openOptions,
              child: Text(StringLabels.selectCoffee),
            ),
            Container(
              child: Text(
                coffee,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ]),
    );
  }
}

class RatioCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  final double _spacing = 15.0;
  final Function(String) doseChanged;
  final Function(String) yieldChanged;
  final Function(String) brewWeightChanged;

  RatioCard({
    this.doseChanged,
    this.yieldChanged,
    this.brewWeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    return 
    
    Card(child:Container(
      margin: EdgeInsets.all(_margin),
      padding: EdgeInsets.all(_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, _padding),
            child: Text(
              StringLabels.ratios,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /// Dose
              Container(
                  width: 100.0,
                  child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: StringLabels.brewingDose,
                      hintText: StringLabels.enterValue,
                    ),
                    onChanged: doseChanged,
                  )),

              /// Yield
              Container(
                  width: 100.0,
                  child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: StringLabels.yield,
                      hintText: StringLabels.enterValue,
                    ),
                    onChanged: yieldChanged,
                  )),

              /// Brew wieght
              Container(
                  width: 100.0,
                  child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: StringLabels.brewWeight,
                      hintText: StringLabels.enterValue,
                    ),
                    onChanged: brewWeightChanged,
                  )),
            ],
          ),
        ],
      ),
    ));
  }
}

class TwoTextfieldCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  final double _spacing = 15.0;
  final String titleLeft;
  final String titleRight;
  final String leftHintText;
  final String rightHintText;

  final Function(String) onLeftTextChanged;
  final Function(String) onRightTextChanged;

  TwoTextfieldCard(
      {@required this.onLeftTextChanged,
      @required this.onRightTextChanged,
      @required this.titleLeft,
      @required this.leftHintText,
      @required this.titleRight,
      @required this.rightHintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(_margin),
      child: Container(
        padding: EdgeInsets.all(_padding),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  /// Left
                  Container(
                      width: 100.0,
                      child: TextField(
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            labelText: titleLeft, hintText: leftHintText),
                        onChanged: onLeftTextChanged,
                      )),

                  // Right
                  Container(
                      width: 100.0,
                      child: TextField(
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            labelText: titleRight, hintText: rightHintText),
                        onChanged: onRightTextChanged,
                      )),
                ],
              ),
            ]),
      ),
    );
  }
}

class NotesCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  final double _spacing = 15.0;
  final Function(String) _onTextChanged;
  final String _title;
  String _notes;

  NotesCard(this._title, this._notes, this._onTextChanged);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      height: 200.0,
      margin: EdgeInsets.all(_margin),
      padding: EdgeInsets.all(_padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_title),
          Container(
              child: TextField(
                  textAlign: TextAlign.start,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                    hintText: StringLabels.enterInfo,
                  ),
                  onChanged: _onTextChanged))
        ],
      ),
    ));
  }
}
