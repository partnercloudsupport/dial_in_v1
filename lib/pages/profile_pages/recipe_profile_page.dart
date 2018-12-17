
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
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/images.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'dart:io';

class RecipePage extends StatefulWidget{

  final Function(ProfileType) _showOptions;
  final double _margin; 
  final Profile _profile;

  // Sets a String and Value in the Parent profie
  Function(String , dynamic) _setProfileItemValue;

  RecipePage(this._profile, this._margin, this._setProfileItemValue, this._showOptions);

  _RecipePageState createState() => new _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {

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

              ///Coffee
              ProfileInputWithDetailsCard(
                widget._profile.getProfileProfile(ProfileType.coffee),
                StringLabels.daysRested,
                '10',
                (){widget._showOptions(ProfileType.coffee);},),

              ///Barista
              ProfileInputCard(
                widget._profile.getProfileProfile(ProfileType.barista),
                (){widget._showOptions(ProfileType.barista);},),


              ProfileInputCardWithAttribute(
                  imageRefString: Images.drop,
                  title: StringLabels.water,
                  keyboardType: TextInputType.number,
                  onAttributeTextChange: (text) {
                    widget._setProfileItemValue( DatabaseIds.temparature,text);
                  },
                  onProfileTextPressed: () {
                    widget._showOptions(ProfileType.water);
                  },
                  attributeTextfieldText: widget._profile.getProfileItemValue(
                       DatabaseIds.temparature),
                  attributeHintText: StringLabels.enterValue,
                  attributeTitle: StringLabels.temparature,
                  profileName: widget._profile.getProfileProfileTitleValue( profileDatabaseId: DatabaseIds.water)),

              /// Grinder
              ProfileInputCardWithAttribute(
                  imageRefString: Images.grinder,
                  title: StringLabels.grinder,
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
                  profileName: widget._profile.getProfileProfileTitleValue( profileDatabaseId: DatabaseIds.grinder)),

              /// Equipment
              ProfileInputCardWithAttribute(
                  imageRefString: Images.aeropressSmaller512x512,
                  title: StringLabels.brewingEquipment,
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