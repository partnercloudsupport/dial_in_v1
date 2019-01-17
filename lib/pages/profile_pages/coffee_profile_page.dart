import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:intl/intl.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/item.dart';

/// Page
class CoffeeProfilePage extends StatefulWidget {
  final Profile _profile;
  final _isEditing;
  final Function(Item) _showPickerMenu;
 

// Sets a String and Value in the Parent profile
  final Function(String, dynamic) _setProfileItemValue;

  CoffeeProfilePage(this._profile, this._setProfileItemValue, this._isEditing, this._showPickerMenu);

  _CoffeeProfilePageState createState() => new _CoffeeProfilePageState();
}

class _CoffeeProfilePageState extends State<CoffeeProfilePage> {

  Profile _profile;
  

  @override
  void initState() { 
        super.initState();
  }

   @override
  void didChangeDependencies() {
    _profile = widget._profile; 
    super.didChangeDependencies();
    }


  /// UI Build
  @override
  Widget build(BuildContext context) {
    return new 
          Column(
            children: <Widget>[

              Card(child:
                Container(padding: EdgeInsets.all(20.0), alignment: Alignment(0, 1),
                  child:TextFieldWithInitalValue(TextInputType.text, StringLabels.name, StringLabels.enterNickname,
               _profile.getItemValue( DatabaseIds.coffeeId),
                (name){ widget._setProfileItemValue(DatabaseIds.coffeeId,name);}, double.infinity, widget._isEditing),)),

              RoastingDetailsCard(
              ///Values
                _profile.getProfileItem( DatabaseIds.roastProfile),
                _profile.getProfileItem( DatabaseIds.roasteryName),
                _profile.getProfileItem( DatabaseIds.roasterName),
                _profile.getItemValue( DatabaseIds.roastDate), 
              /// Functions
                widget._showPickerMenu,
                (roasteryName){widget._setProfileItemValue( DatabaseIds.roasteryName,  roasteryName);}, 
                (roasterName){widget._setProfileItemValue( DatabaseIds.roasterName,  roasterName);}, 
                (roastDate){widget._setProfileItemValue( DatabaseIds.roastDate,  roastDate);},
                widget._isEditing),

              ///Origin details
              OriginDetailsCard(
                (altitude){widget._setProfileItemValue( DatabaseIds.altitude,  altitude);},
                (lot){widget._setProfileItemValue( DatabaseIds.lot,  lot);},
                (producer){widget._setProfileItemValue( DatabaseIds.producer,  producer);},
                (farm){widget._setProfileItemValue( DatabaseIds.farm,  farm);},
                (region){widget._setProfileItemValue( DatabaseIds.region,  region);},
                widget._showPickerMenu,
                _profile.getProfileItem(DatabaseIds.region),
                _profile.getProfileItem(DatabaseIds.farm) ,
                _profile.getProfileItem(DatabaseIds.producer) ,
                _profile.getProfileItem(DatabaseIds.lot) ,
                _profile.getProfileItem(DatabaseIds.altitude) ,
                _profile.getProfileItem(DatabaseIds.country),
                widget._isEditing),

              /// Green details
              GreenDetailsCard(
                widget._showPickerMenu,
                widget._showPickerMenu,
                widget._showPickerMenu,
                (density){widget._setProfileItemValue( DatabaseIds.density,  density );},
                (aw){widget._setProfileItemValue( DatabaseIds.aW,  aw );},
                (moi){widget._setProfileItemValue( DatabaseIds.moisture,  moi );}, 
                (harvest){widget._setProfileItemValue( DatabaseIds.harvest,  harvest );}, 
                _profile.getProfileItem(DatabaseIds.beanType),
                _profile.getProfileItem(DatabaseIds.beanSize),
                _profile.getProfileItem(DatabaseIds.processingMethod),
                _profile.getProfileItem(DatabaseIds.density),
                _profile.getProfileItem(DatabaseIds.aW),
                _profile.getProfileItem(DatabaseIds.moisture),
                _profile.getProfileItem(DatabaseIds.harvest),
                widget._isEditing),
                
              ],
          );
  }
}

//Widgets

/// Origin details
class OriginDetailsCard extends StatelessWidget {
  final double _padding = 5.0;
  final double _margin = 5.0;
  final double _textFieldWidth = 150.0;
  final Function(String) _region;
  final Function(String) _farm;
  final Function(String) _producer;
  final Function(String) _lot;
  final Function(String) _altitude;
  final Function(Item) _country;
  final Item _regionItem;
  final Item _farmItem;
  final Item _producerItem;
  final Item _lotItem;
  final Item _altitudeItem;
  final Item _countryItem;
  final bool _isEditing;

  OriginDetailsCard(
    /// Functions
    this._altitude, this._lot, this._producer, this._farm, this._region, this._country,
    /// Values
    this._regionItem,this._farmItem, this._producerItem, this._lotItem,this._altitudeItem, this._countryItem,
    /// Editing
    this._isEditing
  );

 @override
  Widget build(BuildContext context) {
    return Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        Text(StringLabels.originDetails, style: Theme.of(context).textTheme.title,),
        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Region
          TextFieldItemWithInitalValue(_regionItem, (value){_region(value);},_textFieldWidth, _isEditing),
          
          ///Farm
          TextFieldItemWithInitalValue( _farmItem, (value){_farm(value);}, _textFieldWidth, _isEditing),              
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
        ///Producer
          TextFieldItemWithInitalValue(_producerItem, (value){_producer(value);},_textFieldWidth, _isEditing), 
        ///Lot
          TextFieldItemWithInitalValue(_lotItem, (value){_lot(value);}, _textFieldWidth, _isEditing),                
        ],),

        ///Row 3
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Alititude
          TextFieldItemWithInitalValue(_altitudeItem, (value){_altitude(value);}, _textFieldWidth, _isEditing), 
          ///Country
          PickerTextField(_countryItem, _country, _textFieldWidth, _isEditing ),
        ],)
    ],),)
    );
  }
}

/// Roasting details
class RoastingDetailsCard extends StatefulWidget {
 
  final Function(Item) _roastProfile;
  final Function(String) _roasteryName; 
  final Function(String) _roasterName; 
  final Function(DateTime) _roastDate;  
  final Item _roastProfileItem;
  final Item _roasteryNameItem;
  final Item _roasterNameItem;
  final DateTime _roastDateItem;
  final bool _isEditing;
 
  final dateFormat = DateFormat.yMd();

  RoastingDetailsCard( 
    /// Variables
    this._roastProfileItem,this._roasteryNameItem,this._roasterNameItem,this._roastDateItem,
    ///Functions
    this._roastProfile,this._roasteryName, this._roasterName, this._roastDate,
    /// Editing
    this._isEditing);
  

  RoastingDetailsCardState createState() => new RoastingDetailsCardState();
}

class RoastingDetailsCardState extends State<RoastingDetailsCard> {
  final double _margin = 5.0;
  final double _textFieldWidth = 150.0;
  Item _roastProfileItem;
  Item _roasteryNameItem;
  Item _roasterNameItem;
  DateTime _roastDateItem;
  TextEditingController _controller = new TextEditingController();
  
  @override
  void initState() {
    _roastProfileItem = widget._roastProfileItem;
    _roasteryNameItem = widget._roasteryNameItem;
    _roasterNameItem = widget._roasterNameItem;
    _roastDateItem = widget._roastDateItem;
    _controller.text = widget.dateFormat.format(widget._roastDateItem);
    super.initState();
  }

 @override
  Widget build(BuildContext context) {
    return Card(child:
    
     Container(padding: EdgeInsets.all( _margin), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        /// Title
        Container(padding: EdgeInsets.all( _margin), margin: EdgeInsets.all( _margin), child: 
        Text(StringLabels.roastedCoffeeDetails, style: Theme.of(context).textTheme.title,),),

        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
      
        DateInputCard(
          StringLabels.date,
          _roastDateItem,
          (dateTime)
            {if (dateTime != null){ widget._roastDate(dateTime);}},
          widget._isEditing),

        ///Roast profile
          PickerTextField
          (_roastProfileItem, widget._roastProfile, _textFieldWidth, widget._isEditing),                  
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Roastery Name
          TextFieldItemWithInitalValue(_roasteryNameItem,
                (value){
                  _roasteryNameItem.value = value as String;
                  setState(widget._roasteryName(value));}, _textFieldWidth, widget._isEditing) ,    
          
          /// Roaster name
          TextFieldItemWithInitalValue(_roasterNameItem,
                (value){
                  _roasterNameItem.value = value as String;
                  setState(widget._roasterName(value));}, _textFieldWidth, widget._isEditing),                                  
        ],)
    ],))
    );
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
  final double _padding = 5.0;
  final double _margin = 5.0;
  final double _textFieldWidth = 150.0;
  final Function(Item) _beanType;
  final Function(Item) _beanSize;
  final Function(Item) _processingMethod;
  final Function(String) _density;
  final Function(String) _aw;
  final Function(String) _moi;
  final Function(String) _harvest;

  final Item _beanTypeItem;
  final Item _beanSizeItem;
  final Item _processingMethodItem;
  final Item _densityItem;
  final Item _awItem;
  final Item _moiItem;
  final Item _harvestItem;

  final bool _isEditing;

  GreenDetailsCard(
    /// Functions
    this._beanType,this._beanSize,this._processingMethod,this._density, this._aw,this._moi,this._harvest,
    /// Values
    this._beanTypeItem,this._beanSizeItem,this._processingMethodItem,this._densityItem ,this._awItem,this._moiItem,this._harvestItem,
    /// Editing
    this._isEditing
  );

 @override
  Widget build(BuildContext context) {
    return Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[


        /// Name
        Text(StringLabels.greenCoffeeDetails, style: Theme.of(context).textTheme.title,),

        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///BeanType
          PickerTextField(_beanTypeItem, _beanType, _textFieldWidth, _isEditing),
        
          ///BeanSize
          PickerTextField(_beanSizeItem, _beanSize ,_textFieldWidth, _isEditing),
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Processing Methord
          PickerTextField(_processingMethodItem, _processingMethod,_textFieldWidth, _isEditing),
          ///Density
          TextFieldItemWithInitalValue(_densityItem, (value){_density(value);}, _textFieldWidth, _isEditing)                
        ],),

        ///Row 3
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Water activity
          TextFieldItemWithInitalValue(_awItem, (value){_aw(value);},_textFieldWidth, _isEditing),
          ///moisture Content
          TextFieldItemWithInitalValue(_moiItem, (value){_moi(value);},_textFieldWidth,_isEditing)                  
        ],),

        ///Row 4
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Harvest
          TextFieldItemWithInitalValue(_harvestItem,(value){_harvest(value);}, _textFieldWidth, _isEditing),

        /// Harvest to implement TODO
        // DateTimeInputCard(
        //   StringLabels.harvest,
        //   DateTime.now(),
        //   (dateTime)
        //   {},
        //   _isEditing
        // ),
                     
        ],),

    ],))
    );
}
}
