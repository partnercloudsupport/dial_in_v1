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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  @required final bool isCopying;
  @required final bool isEditing;
  @required final bool isNew;
  @required final ProfileType type;
  @required final String referance;
  String appBarTitle;
  Profile _profile;

  ProfilePage(
      {this.isCopying, this.isEditing, this.isNew, this.type, this.referance}) {
    if (isNew || isCopying) {
      this.appBarTitle = StringLabels.newe +
          ' ' +
          Functions.getProfileTypeString(type) +
          ' ' +
          StringLabels.profile;
    }

    _profile = Functions.createBlankProfile(type);
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
  @required bool _isCopying;
  @required bool _isEditing;
  @required bool _isNew;

  void initState() {
    _isCopying = widget.isCopying;
    _isEditing = widget.isEditing;
    _isNew = widget.isNew;
    _profile = widget._profile;
    _profile = widget._profile;
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
                              type: Functions.getProfileDatabaseIdType(databaseID),
                              referance: '',
                            )));
              },
              child: Text('Add new profile'),
            ),
            StreamBuilder(
                stream: Firestore.instance.collection(databaseID).snapshots(),
                initialData: 10,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return LinearProgressIndicator();
                    case ConnectionState.active:
                    case ConnectionState.done:
                      print(snapshot.error);

                      if (!snapshot.hasData) {
                        return const Center(child: Text('Loading'));
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error'));
                      // } else if (snapshot.data.documents.length < 1) {
                      //   return const Center(child: Text('No data'));
                      } else {

                        return 
                        new Container(
                          height: 100.0,
                          width: 100.0,
                          child: new 
                         ListView.builder(
                            itemExtent: 80,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) =>
                              
          Functions.buildProfileCard(context, snapshot.data.documents[index], databaseID)

          ))
          
          ;}

                      }
                  }
                )
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

              CoffeeCard(() {
                _showDialog(DatabaseIds.coffee);
              },
                  _profile.getProfileProfileTitleValue(
                      profileDatabaseId: DatabaseIds.coffee)),

              UserDateInputCard(onBaristaPressed: () {
                _showDialog(DatabaseIds.Barista);
              }),

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
                  profileTextfieldText: _profile.getProfileItemValue(
                      itemDatabaseId: DatabaseIds.waterID),
                  attributeTextfieldText: _profile.getProfileItemValue(
                      itemDatabaseId: DatabaseIds.temparature),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.temparature),

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
                  profileTextfieldText: _profile.getProfileItemValue(
                      itemDatabaseId: DatabaseIds.grinderId),
                  attributeTextfieldText: _profile.getProfileItemValue(
                      itemDatabaseId: DatabaseIds.grindSetting),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.setting,
                  keyboardType: TextInputType.number),

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
                  profileTextfieldText: _profile.getProfileItemValue(
                      itemDatabaseId: DatabaseIds.equipmentId),
                  attributeTextfieldText: _profile.getProfileItemValue(
                      itemDatabaseId: DatabaseIds.preinfusion),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.preinfusion),

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
                titleRight: StringLabels.tds,
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
                  (text) {}),

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
                        })
                        /// End of score
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
              widget._sliderValue;
            },
            onChangeEnd: (value) {},
            onChangeStart: (value) {},
            min: 0,
            max: 10,
            divisions: 10,
            label: _value.toInt().toString(),
            activeColor: Theme.of(context).sliderTheme.inactiveTrackColor,
            inactiveColor: Theme.of(context).sliderTheme.inactiveTrackColor,
            // semanticFormatterCallback: ,
          )
        ]);
  }
}

////
/// Widgets
///
class ProfileInputCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;

  final String imageRefString;
  final String title;
  final Function(String) onAttributeTextChange;
  final Function onProfileTextPressed;
  final String profileTextfieldText;
  final String attributeTextfieldText;
  final String attributeHintText;
  final String profileHintText = StringLabels.chooseProfile;
  final String attributeTitle;
  final double _spacing = 5.0;
  final TextInputType keyboardType;

  ProfileInputCard(
      {this.imageRefString,
      this.title,
      this.onAttributeTextChange,
      this.onProfileTextPressed,
      this.attributeTextfieldText,
      this.attributeHintText,
      this.attributeTitle,
      this.profileTextfieldText,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(_margin),
        child: Container(
            padding: EdgeInsets.all(_padding),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, _margin),
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: onProfileTextPressed,
                          child: Text(
                            StringLabels.selectProfile,
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, _margin),
                            width: 40.0,
                            height: 40.0,
                            child: Image.asset(
                              imageRefString,
                              fit: BoxFit.cover,
                            )),

                        Container(
                          width: _spacing,
                          height: _spacing,
                        ),

                        Container(
                            width: _textFieldWidth,
                            child: TextField(
                              textAlign: TextAlign.end,
                              keyboardType: keyboardType,
                              decoration: new InputDecoration(
                                labelText: attributeTitle,
                                hintText: attributeHintText,
                              ),
                              onChanged: onAttributeTextChange,
                            ))
                      ])
                ])));
  }
}

/// User profile

class UserDateInputCard extends StatefulWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  final double _spacing = 15.0;
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");

  final Function onBaristaPressed;
  DateTime _date;
  String _barista;

  UserDateInputCard({
    this.onBaristaPressed,
  });

  UserDateInputCardState createState() => new UserDateInputCardState();
}

class UserDateInputCardState extends State<UserDateInputCard> {
  DateTime _date;

  @override
  void initState() {
    _date = widget._date;
    super.initState();
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
                      format: widget.dateFormat,
                      decoration: InputDecoration(labelText: 'Date'),
                      onChanged: (dt) => setState(() => _date = dt),
                    ),
                  ),

                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              StringLabels.barista,
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                          ),
                          Container(
                            width: 10.0,
                            height: widget._spacing,
                          ),
                          RawMaterialButton(
                              onPressed: widget.onBaristaPressed,
                              child: Text(StringLabels.barista,
                                  style: TextStyle(fontSize: 20)))
                        ]),
                  )
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
  String coffee;

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
                StringLabels.coffee,
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
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          StringLabels.brewingDose,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                      Container(
                        width: 15.0,
                        height: _spacing,
                      ),
                      Container(
                          width: _textFieldWidth,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration.collapsed(
                                hintText: StringLabels.enterInfo),
                            onChanged: doseChanged,
                          ))
                    ]),
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          StringLabels.yield,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                      Container(
                        width: 10.0,
                        height: _spacing,
                      ),
                      Container(
                          width: _textFieldWidth,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration.collapsed(
                              hintText: StringLabels.enterInfo,
                            ),
                            onChanged: yieldChanged,
                          ))
                    ]),
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          StringLabels.brewWeight,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                      Container(
                        width: 10.0,
                        height: _spacing,
                      ),
                      Container(
                          width: _textFieldWidth,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration.collapsed(
                              hintText: StringLabels.enterInfo,
                            ),
                            onChanged: brewWeightChanged,
                          ))
                    ]),
              )
            ],
          ),
        ],
      ),
    );
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

  final Function(String) onLeftTextChanged;
  final Function(String) onRightTextChanged;

  TwoTextfieldCard(
      {@required this.onLeftTextChanged,
      @required this.onRightTextChanged,
      @required this.titleLeft,
      @required this.titleRight});

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              titleLeft,
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                          ),
                          Container(
                            width: 15.0,
                            height: _spacing,
                          ),
                          Container(
                              width: _textFieldWidth,
                              child: TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration.collapsed(
                                  hintText: StringLabels.enterInfo,
                                ),
                                onChanged: onLeftTextChanged,
                              ))
                        ]),
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              titleRight,
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                          ),
                          Container(
                            width: 10.0,
                            height: _spacing,
                          ),
                          Container(
                              width: _textFieldWidth,
                              child: TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration.collapsed(
                                  hintText: StringLabels.enterInfo,
                                ),
                                onChanged: onRightTextChanged,
                              ))
                        ]),
                  )
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
