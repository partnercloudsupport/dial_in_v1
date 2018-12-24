import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/item.dart';

/// Page
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

/// TODO ;
  void showPickerMenu(Item item){

 showModalBottomSheet(context: context, builder: (BuildContext context){

   if (item.inputViewDataSet == null) {return Center(child: Text('Error No Data for picker'),);  
   
   }else{
  
      return CupertinoPicker.builder(
      onSelectedItemChanged:
      (value){ widget._setProfileItemValue(item.databaseId,item.inputViewDataSet[value]);},
      itemExtent: 30.0,
      itemBuilder: (BuildContext context, int x ){
        Text(item.inputViewDataSet[0][x]);
         }
      );}
    });
  }


  /// UI Build
  @override
  Widget build(BuildContext context) {
    return new 
          Column(
            children: <Widget>[

              TextFieldWithInitalValue(TextInputType.text, StringLabels.name, StringLabels.enterNickname,
               _profile.getProfileItemValue( DatabaseIds.coffeeId),
                (name){ widget._setProfileItemValue(DatabaseIds.coffeeId,name);}),

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
                (country){widget._setProfileItemValue( DatabaseIds.country,  country);},
                _profile.getProfileItemValue(DatabaseIds.region) ,
                _profile.getProfileItemValue(DatabaseIds.farm) ,
                _profile.getProfileItemValue(DatabaseIds.producer) ,
                _profile.getProfileItemValue(DatabaseIds.lot) ,
                _profile.getProfileItemValue(DatabaseIds.altitude) ,
                _profile.getProfileItem(DatabaseIds.country)),

                GreenDetailsCard(
                (beanType){widget._setProfileItemValue(DatabaseIds.beanType,  beanType );},
                (beanSize){widget._setProfileItemValue( DatabaseIds.beanSize,  beanSize );},
                (processingMethod){widget._setProfileItemValue( DatabaseIds.processingMethod,  processingMethod );},
                (density){widget._setProfileItemValue( DatabaseIds.density,  density );},
                (altitude){widget._setProfileItemValue( DatabaseIds.altitude,  altitude );},
                (aw){widget._setProfileItemValue( DatabaseIds.aW,  aw );},
                (moi){widget._setProfileItemValue( DatabaseIds.moisture,  moi );},
                (harvest){widget._setProfileItemValue( DatabaseIds.harvest,  harvest );},
                _profile.getProfileItemValue(DatabaseIds.beanType),
                _profile.getProfileItemValue(DatabaseIds.beanSize),
                _profile.getProfileItemValue(DatabaseIds.processingMethod),
                _profile.getProfileItemValue(DatabaseIds.density),
                _profile.getProfileItemValue(DatabaseIds.altitude),
                _profile.getProfileItemValue(DatabaseIds.aW),
                _profile.getProfileItemValue(DatabaseIds.moisture),
                _profile.getProfileItem(DatabaseIds.harvest),)
              ],
          );
  }
}


//Widgets

/// Origin details
class OriginDetailsCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 150.0;
  final Function(String) _region;
  final Function(String) _farm;
  final Function(String) _producer;
  final Function(String) _lot;
  final Function(String) _altitude;
  final Function(String) _country;
  final String _regionValue;
  final String _farmValue;
  final String _producerValue;
  final String _lotValue;
  final String _altitudeValue;
  final Item _countryItem;

  OriginDetailsCard(
    /// Functions
    this._altitude, this._lot, this._producer, this._farm, this._region, this._country,
    /// Values
  this._regionValue,this._farmValue,this._producerValue,this._lotValue,this._altitudeValue,this._countryItem,
  );

 @override
  Widget build(BuildContext context) {
    return Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        Text(StringLabels.originDetails, style: Theme.of(context).textTheme.title,),
        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Region
          TextFieldWithInitalValue(TextInputType.text, StringLabels.region, StringLabels.enterDescription,
               _regionValue,
                (value){_region(value);}),
          
          ///Farm
          TextFieldWithInitalValue(TextInputType.text, StringLabels.farm, StringLabels.enterDescription,
               _farmValue,
                (value){_farm(value);}),              
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
        ///Producer
          TextFieldWithInitalValue(TextInputType.text, StringLabels.producer, StringLabels.enterName,
               _producerValue,
                (value){_producer(value);}), 
        ///Lot
          TextFieldWithInitalValue(TextInputType.text, StringLabels.lot, StringLabels.enterName,
               _lotValue,
                (value){_lot(value);}),                
        ],),

        ///Row 3
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Alititude
          TextFieldWithInitalValue(TextInputType.number, StringLabels.altitude, StringLabels.enterValue,
               _altitudeValue,
                (value){_altitude(value);}), 
          ///Country
          TextFieldItemWithInitalValue(_countryItem,(value){_country(value);},100.0),
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
 
  final dateFormat = DateFormat.yMd();

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
  final double _textFieldWidth = 150.0;
  String _roastProfileValue;
  String _roasteryNameValue;
  String _roasterNameValue;
  DateTime _roastDateValue;
  TextEditingController _controller = new TextEditingController();
  
  @override
  void initState() {
    _roastProfileValue = widget._roastProfileValue;
    _roasteryNameValue = widget._roasteryNameValue;
    _roasterNameValue = widget._roasterNameValue;
    _roastDateValue = widget._roastDateValue;
    _controller.text = widget.dateFormat.format(widget._roastDateValue);
    super.initState();
  }

 @override
  Widget build(BuildContext context) {
    return Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        /// Title
        Text(StringLabels.roastedCoffeeDetails, style: Theme.of(context).textTheme.title,),

        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Roast Date
          Container(width: _textFieldWidth,
                    child: DateTimePickerFormField(
                      format: widget.dateFormat,
                      decoration: InputDecoration(labelText: StringLabels.date),
                      initialDate: _roastDateValue,
                      controller: _controller,
                      dateOnly: true,
                      onChanged: (date) {
                      if (date != null){           
                      setState(widget._roastDate(date));}}),
                    ),

        ///Roast profile
          TextFieldWithInitalValue(TextInputType.text,StringLabels.roastProfile, StringLabels.enterDescription,
               _roastProfileValue,
                (value){
                  _roastProfileValue = value;
                  setState(widget._roastProfile(value));}),                  
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Roastery Name
          TextFieldWithInitalValue(TextInputType.text,StringLabels.roasteryName, StringLabels.enterDescription,
               _roasteryNameValue,
                (value){
                  _roasteryNameValue = value;
                  setState(widget._roasteryName(value));}),    
          
          /// Roaster name
          TextFieldWithInitalValue(TextInputType.text, StringLabels.roasterName, StringLabels.enterName,
               _roasterNameValue,
                (value){
                  _roasterNameValue = value;
                  setState(widget._roasterName(value));}),                                  
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
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 150.0;
  final Function(String) _beanType;
  final Function(String) _beanSize;
  final Function(String) _processingMethod;
  final Function(String) _density;
  final Function(String) _altitude;
  final Function(String) _aw;
  final Function(String) _moi;
  final Function(String) _harvest;

  final String _beanTypeValue;
  final String _beanSizeValue;
  final String _processingMethodValue;
  final String _densityValue;
  final String _altitudeValue;
  final String _awValue;
  final String _moiValue;
  final Item _harvestItem;

  GreenDetailsCard(
    /// Functions
    this._beanType,this._beanSize,this._processingMethod,this._density,this._altitude,this._aw,this._moi,this._harvest,
    /// Values
    this._beanTypeValue,this._beanSizeValue,this._processingMethodValue,this._densityValue,this._altitudeValue,this._awValue,this._moiValue,this._harvestItem,
  );

 @override
  Widget build(BuildContext context) {
    return Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        Text(StringLabels.greenCoffeeDetails, style: Theme.of(context).textTheme.title,),
        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///BeanType
          TextFieldWithInitalValue(TextInputType.text, StringLabels.beanType, StringLabels.enterDescription,
               _beanTypeValue,
                (value){_beanType(value);}),
        
          ///BeanSize
           TextFieldWithInitalValue(TextInputType.text, StringLabels.beanSize, StringLabels.enterDescription,
               _beanSizeValue,
                (value){_beanSize(value);})          
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Processing Methord
          TextFieldWithInitalValue(TextInputType.text, StringLabels.processingMethod, StringLabels.enterDescription,
               _processingMethodValue,
                (value){_processingMethod(value);}),
          ///Density
          TextFieldWithInitalValue(TextInputType.number, StringLabels.density, StringLabels.enterDescription,
               _densityValue,
                (value){_density(value);})                
        ],),

        ///Row 3
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Water activity
          TextFieldWithInitalValue(TextInputType.number, StringLabels.aW, StringLabels.enterDescription,
               _awValue,
                (value){_aw(value);}),
          ///moisture Content
          TextFieldWithInitalValue(TextInputType.number, StringLabels.moisture, StringLabels.enterDescription,
               _moiValue,
                (value){_moi(value);})                  
        ],),

        ///Row 4
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Harvest
          TextFieldItemWithInitalValue(_harvestItem,(value){_harvest(value);}, 100.0)
                     
        ],),

    ],))
    );
}
}
