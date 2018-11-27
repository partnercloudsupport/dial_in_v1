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
import '../../widgets/custom_widgets.dart';

class CoffeeProfilePage extends StatefulWidget {
  @required final bool isCopying;
  @required final bool isEditing;
  @required final bool isNew;
  @required final ProfileType type;
  @required final String referance;
  String appBarTitle;
  Profile _profile;

  CoffeeProfilePage(
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

  CoffeeProfilePageState createState() => new CoffeeProfilePageState();
}

class CoffeeProfilePageState extends State<CoffeeProfilePage> {
  double _padding = 20.0;
  double _margin = 10.0;
  double _textFieldWidth = 120.0;
  double _cornerRadius = 20.0;
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
      body: 

      ListView(
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
              ProfileImage(Image.asset(Images.coffeeBeans)),

              FlatButton(
                onPressed: () {},
                child: Text(StringLabels.changeImage),
              ),

              Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all(_margin),
                    child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.name,
                    hintText: StringLabels.enterNickname,
                              ),
                              onChanged:(name){ _profile.setProfileItemValue(itemDatabaseId: DatabaseIds.coffeeId, value: name);},
                            )),  

              RoastingDetailsCard( 
                 (roastprofile){ _profile.setProfileItemValue(itemDatabaseId: DatabaseIds.roastProfile, value: roastprofile);},
                 (roastryName){ _profile.setProfileItemValue(itemDatabaseId: DatabaseIds.roasteryName, value: roastryName);},
                  // _profile.getProfileItemValue(itemDatabaseId: DatabaseIds.roastDate),
                  ),

              OriginDetailsCard(
                (altitude){ _profile.setProfileItemValue(itemDatabaseId: DatabaseIds.altitude, value: altitude);},
                (lot){ _profile.setProfileItemValue(itemDatabaseId: DatabaseIds.lot, value: lot);},
                (producer){ _profile.setProfileItemValue(itemDatabaseId: DatabaseIds.producer, value: producer);},
                (farm){ _profile.setProfileItemValue(itemDatabaseId: DatabaseIds.farm, value: farm);},
                (region){ _profile.setProfileItemValue(itemDatabaseId: DatabaseIds.region, value: region);},
                (country){ _profile.setProfileItemValue(itemDatabaseId: DatabaseIds.country, value: country);},),

                GreenDetailsCard(
                (beanType){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.beanType, value: beanType );},
                (beanSize){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.beanSize, value: beanSize );},
                (processingMethod){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.processingMethod, value: processingMethod );},
                (density){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.density, value: density );},
                (altitude){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.altitude, value: altitude );},
                (aw){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.aW, value: aw );},
                (moi){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.moisture, value: moi );},
                (harvest){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.harvest, value: harvest );})

              ],
          )
        ],
      ),
      );}
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
 
  // final Function(String) _roastDate;
  final Function(String) _roastProfile;
  final Function(String) _roasteryName;  
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  // final DateTime _date;

  RoastingDetailsCard( this._roastProfile,this._roasteryName,
  //  this._date
   );
  

  RoastingDetailsCardState createState() => new RoastingDetailsCardState();
}

class RoastingDetailsCardState extends State<RoastingDetailsCard> {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  DateTime _date;

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
                      onChanged: (dt) => 
                      setState(() => _date = dt)),
                    ),
          ///Roast profile
          Container(width: _textFieldWidth,
                    child: TextField(
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
               
        ],)
    ],))
    );
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
