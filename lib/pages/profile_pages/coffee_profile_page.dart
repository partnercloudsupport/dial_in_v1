import '../../data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../database_functions.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import '../../data/profile.dart';


class CoffeeProfilePage extends StatefulWidget {
  final double _margin;
  final Profile _profile;

// Sets a String and Value in the Parent profile
  final Function(String, dynamic) _setProfileItemValue;

  CoffeeProfilePage(this._profile, this._margin, this._setProfileItemValue);

  _CoffeeProfilePageState createState() => new _CoffeeProfilePageState();
}

class _CoffeeProfilePageState extends State<CoffeeProfilePage> {
  final double _padding = 20.0;
  final double _margin = 10.0;
  Profile _profile;

  @override
  void initState() {
    _profile = widget._profile;
    super.initState();
  }

  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new 
          Column(
            children: <Widget>[

              TextFieldWithInitalValue(StringLabels.name, StringLabels.enterNickname,
               _profile.getProfileItemValue( DatabaseIds.coffeeId),
                (name){ widget._setProfileItemValue(DatabaseIds.coffeeId,name);}),

              Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all(_margin),
                    child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.name,
                    hintText: StringLabels.enterNickname,
                              ),
                              onChanged:(name){ widget._setProfileItemValue(DatabaseIds.coffeeId,name);},
                            )),  

              RoastingDetailsCard(
              ///Values
                _profile.getProfileItemValue( DatabaseIds.roastProfile),
                _profile.getProfileItemValue( DatabaseIds.roasteryName),
                _profile.getProfileItemValue( DatabaseIds.roasterName),
                _profile.getProfileItemValue( DatabaseIds.roastDate), 
              /// Functions
                (roastProfile){widget._setProfileItemValue( DatabaseIds.roastProfile,  roastProfile);}, 
                (roasteryName){widget._setProfileItemValue( DatabaseIds.roasteryName,  roasteryName);}, 
                (roasterName){widget._setProfileItemValue( DatabaseIds.roasterName,  roasterName);}, 
                (roastDate){widget._setProfileItemValue( DatabaseIds.roastDate,  roastDate);}),

              OriginDetailsCard(
                (altitude){widget._setProfileItemValue( DatabaseIds.altitude,  altitude);},
                (lot){widget._setProfileItemValue( DatabaseIds.lot,  lot);},
                (producer){widget._setProfileItemValue( DatabaseIds.producer,  producer);},
                (farm){widget._setProfileItemValue( DatabaseIds.farm,  farm);},
                (region){widget._setProfileItemValue( DatabaseIds.region,  region);},
                (country){widget._setProfileItemValue( DatabaseIds.country,  country);},),

                GreenDetailsCard(
                (beanType){widget._setProfileItemValue(DatabaseIds.beanType,  beanType );},
                (beanSize){widget._setProfileItemValue( DatabaseIds.beanSize,  beanSize );},
                (processingMethod){widget._setProfileItemValue( DatabaseIds.processingMethod,  processingMethod );},
                (density){widget._setProfileItemValue( DatabaseIds.density,  density );},
                (altitude){widget._setProfileItemValue( DatabaseIds.altitude,  altitude );},
                (aw){widget._setProfileItemValue( DatabaseIds.aW,  aw );},
                (moi){widget._setProfileItemValue( DatabaseIds.moisture,  moi );},
                (harvest){widget._setProfileItemValue( DatabaseIds.harvest,  harvest );})

              ],
          );
  }
}


/// End of Page
///

//Widgets

/// Origin details
class OriginDetailsCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  final Function(String) _region;
  final Function(String) _farm;
  final Function(String) _producer;
  final Function(String) _lot;
  final Function(String) _altitude;
  final Function(String) _country;

  OriginDetailsCard(this._altitude, this._lot, this._producer, this._farm, this._region, this._country);

 @override
  Widget build(BuildContext context) {
    return Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        Text(StringLabels.originDetails, style: Theme.of(context).textTheme.title,),
        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Region
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.region,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _region,
                            )),
          ///Farm
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.lot,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _farm,
                            )),                  
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Producer
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.producer,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _producer,
                            )),
          ///Lot
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.farm,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _lot,
                            )),                  
        ],),

        ///Row 3
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Alititude
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.altitude,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _altitude,
                            )),
          ///Country
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.country,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _country,
                            )),
               
        ],)
    ],),)
    );
}
}

/// Roasting details
class RoastingDetailsCard extends StatefulWidget {
 
  final Function(String) _roastProfile;
  final Function(String) _roasteryName; 
  final Function(String) _roasterName; 
  final Function(DateTime) _roastDate;  
  final String _roastProfileValue;
  final String _roasteryNameValue;
  final String _roasterNameValue;
  final DateTime _roastDateValue;
 
  final dateFormat = DateFormat.yMd().add_jm();

  RoastingDetailsCard( 
    /// Variables
    this._roastProfileValue,this._roasteryNameValue,this._roasterNameValue,this._roastDateValue,
    ///Functions
    this._roastProfile,this._roasteryName, this._roasterName, this._roastDate);
  

  RoastingDetailsCardState createState() => new RoastingDetailsCardState();
}

class RoastingDetailsCardState extends State<RoastingDetailsCard> {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  TextEditingController _roastProfileController;
  TextEditingController _roasteryNameController;
  TextEditingController _roasterNameController;
  TextEditingController _roastDateController;
  
  @override
  void initState() {
    // _date = widget._date;
    super.initState();
  }

 @override
  Widget build(BuildContext context) {
    return Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        Text(StringLabels.roastedCoffeeDetails, style: Theme.of(context).textTheme.title,),
        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Roast Date
          Container(width: _textFieldWidth,
                    child: DateTimePickerFormField(
                      format: widget.dateFormat,
                      decoration: InputDecoration(labelText: StringLabels.date),
                      initialDate: widget._roastDateValue,
                      onChanged: (date) => 
                      setState(widget._roastDate(date))),
                    ),
          ///Roast profile
          Container(width: _textFieldWidth,
                    child: TextField(
                    controller: _roastProfileController ,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.roastProfile,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: widget._roastProfile,
                            )),                  
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Roastery Name
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.roasteryName,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: widget._roasteryName,
                            )),
          /// Roaster name                  
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.roasterName,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: widget._roasterName,
                            )),
               
        ],)
    ],))
    );
}
}




////
/// Widgets
///
class TextFieldWithInitalValue extends StatelessWidget {

final double _textFieldWidth = 150.0;
TextEditingController _controller;
final Function(dynamic) _giveValue;
final dynamic _initalValue; 
final String _titleLabel;
final String _hintText;

TextFieldWithInitalValue(this._titleLabel, this._hintText, this._initalValue, this._giveValue){_controller = new TextEditingController(text: _initalValue);}

@override
  Widget build(BuildContext context) {
    return
Container(width: _textFieldWidth,
                    child: TextField(
                    controller: _controller ,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: _titleLabel,
                    hintText: _hintText,
                              ),
                              onChanged: _giveValue,
                            )); 
  }
  }                
        
class ProfileInputCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
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


///Green details
class GreenDetailsCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  final Function(String) _beanType;
  final Function(String) _beanSize;
  final Function(String) _processingMethod;
  final Function(String) _density;
  final Function(String) _altitude;
  final Function(String) _aw;
  final Function(String) _moi;
  final Function(String) _harvest;

  GreenDetailsCard(
    this._beanType,
    this._beanSize,
    this._processingMethod,
    this._density,
    this._altitude,
    this._aw,
    this._moi,
    this._harvest,
  );

 @override
  Widget build(BuildContext context) {
    return Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        Text(StringLabels.greenCoffeeDetails, style: Theme.of(context).textTheme.title,),
        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///BeanType
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.beanType,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _beanType,
                            )),
          ///BeanSize
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.beanSize,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _beanSize,
                            )),                  
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Processing Methord
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.processingMethod,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _processingMethod,
                            )),
          ///Density
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                    labelText: StringLabels.density,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _density,
                            )),                  
        ],),

        ///Row 3
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Water activity
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                    labelText: StringLabels.aW,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _aw,
                            )),
          ///moisture Content
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                    labelText: StringLabels.moisture,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _moi,
                            )),                  
        ],),

        ///Row 4
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Harvest
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.harvest,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _harvest,
                            )),
                     
        ],),

    ],))
    );
}
}
