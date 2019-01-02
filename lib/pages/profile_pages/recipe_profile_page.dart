
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:flutter/services.dart';
import 'package:dial_in_v1/data/item.dart';




class RecipePage extends StatefulWidget {

  _RecipePageState createState() => _RecipePageState();


  final double _margin; 
  final Function(ProfileType) _showOptions;
  final Profile _profile;
  final bool _isEditing;

  // Sets a String and Value in the Parent profie
  final Function(String , dynamic) _setProfileItemValue;

  RecipePage(this._profile, this._margin, this._setProfileItemValue, this._showOptions, this._isEditing);
}

class _RecipePageState extends State<RecipePage> {

   void showPickerMenu(Item item, BuildContext context){

    int value;
    
    if (item.value == null){value = 0;}
    else if (item.value is String && item.value == ''){value = 0;}
    else if (item.value is double){value = (item.value as double).floorToDouble().toInt();}
    else if (item.value is !int){value = 0;}
    else{value = item.value;}

    List< Widget> _minutes = new List<Widget>();
    List< Widget> _seconds = new List<Widget>();
    double _itemHeight = 40.0; 
    double _pickerHeight = 120.0;
    double _pickerWidth = 50.0;
    int mins = (value/60).floor();
    int sec = value % 60;
   
    if (item.inputViewDataSet != null && item.inputViewDataSet.length > 0)
    {item.inputViewDataSet[0]
    .forEach((itemText){_minutes.add(Center(child:Text(itemText.toString(), style: Theme.of(context).textTheme.display2,)));}
    );}

    if (item.inputViewDataSet != null && item.inputViewDataSet.length > 0)
    {item.inputViewDataSet[1]
    .forEach((itemText){_seconds.add(Center(child:Text(itemText.toString(), style: Theme.of(context).textTheme.display2,)));}
    );}

     showModalBottomSheet(context: context, builder: (BuildContext context){
       
      if (item.inputViewDataSet != null && item.inputViewDataSet.length < 1)
      {return Center(child: Text('Error No Data for picker'),);  

      }else{

    ///TODO;    

    FixedExtentScrollController _minuteController = new FixedExtentScrollController(initialItem: mins);
    FixedExtentScrollController _secondController = new FixedExtentScrollController(initialItem: sec);
  
        return  
        Container(child: SizedBox(height: 200.0, width: double.infinity, child: Column(children: <Widget>[

                    Material(elevation: 5.0, shadowColor: Colors.black, color:Theme.of(context).accentColor, type:MaterialType.card, 
                    child: Container(height: 40.0, width: double.infinity, alignment: Alignment(1, 0),
                    child: FlatButton(onPressed:() => Navigator.pop(context),
                    child: Text('Done')),)),

               SizedBox(height: 160.0, width: double.infinity  ,child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,  
                children: <Widget>[

                  /// Minutes picker
                  Row(children: <Widget>[
                    SizedBox(height: _pickerHeight, width: _pickerWidth ,
                    child: CupertinoPicker(
                      backgroundColor: Colors.transparent,
                      scrollController: _minuteController,
                      useMagnifier: true,
                      onSelectedItemChanged:
                        (value){
                          mins = value;
                          widget._setProfileItemValue(item.databaseId, ((mins * 60) + sec).toString());
                        }, 
                      itemExtent: _itemHeight,
                      children: _minutes
                      ),),
                      Text('m')
                  ],),

                  /// Seconds picker
                   Row(children: <Widget>[
                       SizedBox(height: _pickerHeight, width: _pickerWidth  ,
                    child: CupertinoPicker(
                      backgroundColor:  Colors.transparent,
                      scrollController: _secondController,
                      useMagnifier: true,
                      onSelectedItemChanged:
                        (value){
                          sec = value;
                          widget._setProfileItemValue(item.databaseId,  ((mins * 60) + sec).toString());

                        }, 
                      itemExtent: _itemHeight,
                      children: _seconds
                      ),),
                    Text('s'),

                        ],
                    )
                ],))
        ],) )
      );
      }
      }
    );
}


  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return  
    Column(children: <Widget>[ 

            /// Date
              DateTimeInputCard(StringLabels.date,
                  widget._profile.getProfileItemValue( DatabaseIds.date),
                  (dateTime)
                  {if (dateTime != null){ widget._setProfileItemValue( DatabaseIds.date, dateTime);}},
                   widget._isEditing),

            ///Coffee
              ProfileInputWithDetailsCard(
                widget._profile.getProfileProfile(ProfileType.coffee),
                StringLabels.rested,
                widget._profile.getDaysRested().toString() + ' days',
                (){widget._showOptions(ProfileType.coffee);},),

            ///Barista
              ProfileInputCard(
                widget._profile.getProfileProfile(ProfileType.barista),
                (){widget._showOptions(ProfileType.barista);},),

            /// Water
              ProfileInputCardWithAttribute(widget._isEditing,
                  profile: widget._profile.getProfileProfile(ProfileType.water),
                  keyboardType: TextInputType.number,
                  onAttributeTextChange: (text) {
                    widget._setProfileItemValue( DatabaseIds.temparature, text);
                  },
                  onProfileTextPressed: () {
                    widget._showOptions(ProfileType.water);
                  },
                  attributeTextfieldText: widget._profile.getProfileItemValue(
                       DatabaseIds.temparature),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.degreeC,
                  ),

            /// Grinder
              ProfileInputCardWithAttribute(widget._isEditing,
                  profile: widget._profile.getProfileProfile(ProfileType.grinder),
                  onAttributeTextChange: (text) {
                    widget._setProfileItemValue(DatabaseIds.grindSetting, text);
                  },
                  onProfileTextPressed: () {
                    widget._showOptions(ProfileType.grinder);
                  },
                  attributeTextfieldText: widget._profile.getProfileItemValue(
                       DatabaseIds.grindSetting),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.setting,
                  keyboardType: TextInputType.number,
              ),

            /// Equipment
              ProfileInputCardWithAttribute(widget._isEditing,
                  profile: widget._profile.getProfileProfile(ProfileType.equipment),
                  onAttributeTextChange: (text) {
                    widget._setProfileItemValue(DatabaseIds.preinfusion, text);
                  },
                  onProfileTextPressed: () {
                    widget._showOptions(ProfileType.equipment);
                  },
                  attributeTextfieldText: widget._profile.getProfileItemValue(
                       DatabaseIds.preinfusion),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.preinfusion,
              ),

              /// Ratio card
               RatioCard(
                widget._profile,
                (dose) {widget._setProfileItemValue( DatabaseIds.brewingDose, dose);},  
                (yielde) {widget._setProfileItemValue( DatabaseIds.yielde, yielde);},
                (brewWeight) { widget._setProfileItemValue( DatabaseIds.brewWeight, brewWeight);},
                widget._isEditing),

              /// Time
              Card(child: Container(margin: EdgeInsets.all(10.0), child: Row(children: <Widget>[
                
                 TimePickerTextField(
                  widget._profile.getProfileItem(DatabaseIds.time),
                  (item) => showPickerMenu(item, context),
                  100.0, 
                  widget._isEditing)

                  ],)),),

              /// Extraction and TDS
              TwoTextfieldCard(
                (tds) { widget._setProfileItemValue( DatabaseIds.tds, tds);},
                widget._profile.getProfileItem(DatabaseIds.tds),
                widget._isEditing,
                widget._profile.getExtractionYield() 
              ),

              /// Notes
              NotesCard(
                  StringLabels.notes,
                  widget._profile.getProfileItemValue(
                       DatabaseIds.notes),
                  (notes) {widget._setProfileItemValue( DatabaseIds.notes, notes);},
                  widget._isEditing),

              ///Score Section
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(widget._margin),
                      padding: EdgeInsets.all(widget._margin),
                      child: Text(
                        StringLabels.score,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        ScoreSlider(StringLabels.strength, 0.0,
                         (value) { widget._setProfileItemValue( DatabaseIds.strength, value.toString());},
                         widget._isEditing),

                        ScoreSlider(StringLabels.balance, 0.0,
                         (value) { widget._setProfileItemValue( DatabaseIds.balance, value.toString());},
                         widget._isEditing),

                        ScoreSlider(StringLabels.flavour, 0.0,
                         (value) { widget._setProfileItemValue( DatabaseIds.flavour, value.toString());},
                         widget._isEditing),

                        ScoreSlider(StringLabels.body, 0.0,
                         (value) {widget._setProfileItemValue( DatabaseIds.body, value.toString());},
                         widget._isEditing),

                        ScoreSlider(StringLabels.afterTaste, 0.0,
                         (value) {widget._setProfileItemValue( DatabaseIds.afterTaste, value.toString());},
                         widget._isEditing),

                        /// End of score   
                        
                      ],
                    )
                  ],
                ),
              ),
               NotesCard(
                        StringLabels.descriptors,
                        widget._profile.getProfileItemValue(
                             DatabaseIds.descriptors),
                        (text) {widget._setProfileItemValue( DatabaseIds.descriptors, text);},
                        widget._isEditing),
          ],
            );
      }
}