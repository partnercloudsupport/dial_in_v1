
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:flutter/services.dart';
import 'package:dial_in_v1/data/item.dart';

class RecipePage extends StatelessWidget{

  final Function(ProfileType) _showOptions;
  final double _margin; 
  final Profile _profile;
  final bool _isEditing;

  // Sets a String and Value in the Parent profie
  final Function(String , dynamic) _setProfileItemValue;

  RecipePage(this._profile, this._margin, this._setProfileItemValue, this._showOptions, this._isEditing);

   void showPickerMenu(Item item, BuildContext context){

    List< Widget> _minutes = new List<Widget>();
    List< Widget> _seconds = new List<Widget>();
    double _itemHeight = 40.0; 
   
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
    int secondStart = item.inputViewDataSet[0].indexWhere((value) => (value == item.value));
    int minuteStart = item.inputViewDataSet[0].indexWhere((value) => (value == item.value));

    FixedExtentScrollController _minuteController = new FixedExtentScrollController(initialItem: minuteStart);
    FixedExtentScrollController _secondController = new FixedExtentScrollController(initialItem: secondStart);
  
        return  
        Container(child: SizedBox(height: 200.0, width: double.infinity, child: Column(children: <Widget>[

                    Material(elevation: 5.0, shadowColor: Colors.black, color:Theme.of(context).accentColor, type:MaterialType.card, 
                    child: Container(height: 40.0, width: double.infinity, alignment: Alignment(1, 0),
                    child: FlatButton(onPressed:() => Navigator.pop(context),
                    child: Text('Done')),)),

               SizedBox(height: 160.0, width: double.infinity  ,child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,  
                children: <Widget>[

                  Row(children: <Widget>[
                    SizedBox(height: 160.0, width: 50.0 ,
                    child: CupertinoPicker(
                      backgroundColor: Colors.transparent,
                      scrollController: _minuteController,
                      useMagnifier: true,
                      onSelectedItemChanged:
                        (value){
                        //   setState(() {
                        //   widget._setProfileItemValue(item.databaseId, item.inputViewDataSet[0][value]);
                        //   _profile.setProfileItemValue(item.databaseId, item.inputViewDataSet[0][value]);
                        // });
                        }, 
                      itemExtent: _itemHeight,
                      children: _minutes
                      ),),
                      Text('m')
                  ],),

                   Row(children: <Widget>[
                       SizedBox(height: 160.0, width: 50.0  ,
                    child: CupertinoPicker(
                      backgroundColor:  Colors.transparent,
                      scrollController: _secondController,
                      useMagnifier: true,
                      onSelectedItemChanged:
                        (value){
                        //   setState(() {
                        //   widget._setProfileItemValue(item.databaseId, item.inputViewDataSet[0][value]);
                        //   _profile.setProfileItemValue(item.databaseId, item.inputViewDataSet[0][value]);
                        // });
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
                  _profile.getProfileItemValue( DatabaseIds.date),
                  (dateTime)
                  {if (dateTime != null){ _setProfileItemValue( DatabaseIds.date, dateTime);}},
                   _isEditing),

            ///Coffee
              ProfileInputWithDetailsCard(
                _profile.getProfileProfile(ProfileType.coffee),
                StringLabels.rested,
                _profile.getDaysRested().toString() + ' days',
                (){_showOptions(ProfileType.coffee);},),

            ///Barista
              ProfileInputCard(
                _profile.getProfileProfile(ProfileType.barista),
                (){_showOptions(ProfileType.barista);},),

            /// Water
              ProfileInputCardWithAttribute(_isEditing,
                  profile: _profile.getProfileProfile(ProfileType.water),
                  keyboardType: TextInputType.number,
                  onAttributeTextChange: (text) {
                    _setProfileItemValue( DatabaseIds.temparature, text);
                  },
                  onProfileTextPressed: () {
                    _showOptions(ProfileType.water);
                  },
                  attributeTextfieldText: _profile.getProfileItemValue(
                       DatabaseIds.temparature),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.degreeC,
                  ),

            /// Grinder
              ProfileInputCardWithAttribute(_isEditing,
                  profile: _profile.getProfileProfile(ProfileType.grinder),
                  onAttributeTextChange: (text) {
                    _setProfileItemValue(DatabaseIds.grindSetting, text);
                  },
                  onProfileTextPressed: () {
                    _showOptions(ProfileType.grinder);
                  },
                  attributeTextfieldText: _profile.getProfileItemValue(
                       DatabaseIds.grindSetting),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.setting,
                  keyboardType: TextInputType.number,
              ),

            /// Equipment
              ProfileInputCardWithAttribute(_isEditing,
                  profile: _profile.getProfileProfile(ProfileType.equipment),
                  onAttributeTextChange: (text) {
                    _setProfileItemValue(DatabaseIds.preinfusion, text);
                  },
                  onProfileTextPressed: () {
                    _showOptions(ProfileType.equipment);
                  },
                  attributeTextfieldText: _profile.getProfileItemValue(
                       DatabaseIds.preinfusion),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.preinfusion,
              ),

              /// Ratio card
               RatioCard(
                _profile,
                (dose) {_setProfileItemValue( DatabaseIds.brewingDose, dose);},  
                (yielde) {_setProfileItemValue( DatabaseIds.yielde, yielde);},
                (brewWeight) { _setProfileItemValue( DatabaseIds.brewWeight, brewWeight);},
                _isEditing),

              /// Time
              Card(child: Container(margin: EdgeInsets.all(10.0), child: Row(children: <Widget>[
                
                 PickerTextField(
                  _profile.getProfileItem(DatabaseIds.time),
                  (item) => showPickerMenu(item, context),
                  100.0, 
                  _isEditing)

              
                // TextFieldItemWithInitalValue(
                //   _profile.getProfileItem(DatabaseIds.time),
                //   (time) { _setProfileItemValue( DatabaseIds.time, time);},
                //   100.0, 
                //   _isEditing)
                  ],)),),

              /// Extraction and TDS
              TwoTextfieldCard(
                (tds) { _setProfileItemValue( DatabaseIds.tds, tds);},
                _profile.getProfileItem(DatabaseIds.tds),
                _isEditing,
                _profile.getExtractionYield() 
              ),

              /// Notes
              NotesCard(
                  StringLabels.notes,
                  _profile.getProfileItemValue(
                       DatabaseIds.notes),
                  (notes) {_setProfileItemValue( DatabaseIds.notes, notes);},
                  _isEditing),

              ///Score Section
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(_margin),
                      padding: EdgeInsets.all(_margin),
                      child: Text(
                        StringLabels.score,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        ScoreSlider(StringLabels.strength, 0.0,
                         (value) { _setProfileItemValue( DatabaseIds.strength, value.toString());},
                         _isEditing),

                        ScoreSlider(StringLabels.balance, 0.0,
                         (value) { _setProfileItemValue( DatabaseIds.balance, value.toString());},
                         _isEditing),

                        ScoreSlider(StringLabels.flavour, 0.0,
                         (value) { _setProfileItemValue( DatabaseIds.flavour, value.toString());},
                         _isEditing),

                        ScoreSlider(StringLabels.body, 0.0,
                         (value) {_setProfileItemValue( DatabaseIds.body, value.toString());},
                         _isEditing),

                        ScoreSlider(StringLabels.afterTaste, 0.0,
                         (value) {_setProfileItemValue( DatabaseIds.afterTaste, value.toString());},
                         _isEditing),

                        /// End of score
                        
                        
                      ],
                    )
                  ],
                ),
              ),
               NotesCard(
                        StringLabels.descriptors,
                        _profile.getProfileItemValue(
                             DatabaseIds.descriptors),
                        (text) {_setProfileItemValue( DatabaseIds.descriptors, text);},
                        _isEditing),
          ],
            );
      }
}