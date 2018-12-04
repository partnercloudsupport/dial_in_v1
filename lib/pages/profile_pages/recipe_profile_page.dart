
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
import '../../widgets/profile_page_widgets.dart';
import '../../widgets/custom_widgets.dart';


class RecipePage extends StatefulWidget{

  final Function(String) _showOptions;
  final double _margin; 
  final Profile _profile;

  // Sets a String and Value in the Parent profie
  Function(String , dynamic) _setProfileItemValue;

  RecipePage(this._profile, this._margin, this._setProfileItemValue, this._showOptions);

  _RecipePageState createState() => new _RecipePageState();
}


class _RecipePageState extends State<RecipePage> {
  
 Profile _profile;

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies(){
    setState(() {
        });
    super.didChangeDependencies();
  }

  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[ 

              /// Date
              DateInputCard(StringLabels.date,
                  widget._profile.getProfileItemValue( DatabaseIds.date),
                  (dateTime){widget._setProfileItemValue( DatabaseIds.date, dateTime);}),

              /// Coffee and Barista Card
              DoubleProfileInputCard(
                leftHintText: StringLabels.selectCoffee,        
                leftImageRefString: Images.coffeeBeans,
                leftTextfieldText:  widget._profile.getProfileProfileTitleValue(profileDatabaseId: DatabaseIds.coffee),
                leftTitle: StringLabels.coffee,
                onLeftProfileTextPressed: (){widget._showOptions(DatabaseIds.coffee);},
                
                rightHintText: StringLabels.chooseBarista,
                rightImageRefString: Images.user,
                rightTextfieldText: widget._profile.getProfileProfileTitleValue(profileDatabaseId: DatabaseIds.Barista),
                rightTitle: StringLabels.barista ,
                onRightProfileTextPressed: (){widget._showOptions(DatabaseIds.Barista);} ), 
        
              ///Water Section
              ProfileInputCard(
                  imageRefString: Images.drop,
                  title: StringLabels.water,
                  keyboardType: TextInputType.number,
                  onAttributeTextChange: (text) {
                    widget._setProfileItemValue( DatabaseIds.temparature,text);
                  },
                  onProfileTextPressed: () {
                    widget._showOptions(DatabaseIds.water);
                  },
                  attributeTextfieldText: widget._profile.getProfileItemValue(
                       DatabaseIds.temparature),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.temparature,
                  profileName: widget._profile.getProfileProfileTitleValue( profileDatabaseId: DatabaseIds.water)),

              /// Grinder
              ProfileInputCard(
                  imageRefString: Images.grinder,
                  title: StringLabels.grinder,
                  onAttributeTextChange: (text) {
                    widget._setProfileItemValue(DatabaseIds.grindSetting, text);
                  },
                  onProfileTextPressed: () {
                    widget._showOptions(DatabaseIds.grinder);
                  },
                  attributeTextfieldText: widget._profile.getProfileItemValue(
                       DatabaseIds.grindSetting),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.setting,
                  keyboardType: TextInputType.number,
                  profileName: widget._profile.getProfileProfileTitleValue( profileDatabaseId: DatabaseIds.grinder)),

              /// Equipment
              
              ProfileInputCard(
                  imageRefString: Images.aeropressSmaller512x512,
                  title: StringLabels.brewingEquipment,
                  onAttributeTextChange: (text) {
                    widget._setProfileItemValue(DatabaseIds.preinfusion, text);
                  },
                  onProfileTextPressed: () {
                    widget._showOptions(DatabaseIds.brewingEquipment);
                  },
                  attributeTextfieldText: widget._profile.getProfileItemValue(
                       DatabaseIds.preinfusion),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.preinfusion,
                  profileName: widget._profile.getProfileProfileTitleValue( profileDatabaseId: DatabaseIds.brewingEquipment)),

            /// Ratio card

            RatioCard(
              doseChanged: (dose) {
                widget._setProfileItemValue( DatabaseIds.brewingDose, dose);
              }, yieldChanged: ((yielde) {
                widget._setProfileItemValue( DatabaseIds.yielde, yielde);
              }), brewWeightChanged: (brewWeight) {
                widget._setProfileItemValue( DatabaseIds.brewWeight, brewWeight);
              }),

              TwoTextfieldCard(
                titleLeft: StringLabels.time,
                leftHintText: StringLabels.setTime,
                titleRight: StringLabels.tds,
                rightHintText: StringLabels.enterValue,
                onLeftTextChanged: (time) { widget._setProfileItemValue( DatabaseIds.time, time);},
                onRightTextChanged: (tds) { widget._setProfileItemValue( DatabaseIds.tds, tds);},
              ),

              NotesCard(
                  StringLabels.notes,
                  widget._profile.getProfileItemValue(
                       DatabaseIds.notes),
                  (notes) {widget._setProfileItemValue( DatabaseIds.notes, notes);}),

              ///Score Section
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(widget._margin),
                      child: Text(
                        StringLabels.score,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        ScoreSlider(StringLabels.strength, 0.0, (value) { widget._setProfileItemValue( DatabaseIds.strength, value);}),

                        ScoreSlider(StringLabels.balance, 0.0, (value) { widget._setProfileItemValue( DatabaseIds.balance, value);}),

                        ScoreSlider(StringLabels.flavour, 0.0, (value) { widget._setProfileItemValue( DatabaseIds.flavour, value);}),

                        ScoreSlider(StringLabels.body, 0.0, (value) {widget._setProfileItemValue( DatabaseIds.body, value);}),

                        ScoreSlider(StringLabels.afterTaste, 0.0, (value) {widget._setProfileItemValue( DatabaseIds.afterTaste, value);}),

                        /// End of score
                        
                        NotesCard(
                        StringLabels.descriptors,
                        widget._profile.getProfileItemValue(
                             DatabaseIds.descriptors),
                        (text) {widget._setProfileItemValue( DatabaseIds.descriptors, text);}), 
                      ],
                    )
                  ],
                ),
              ),
          ],);
      }
}