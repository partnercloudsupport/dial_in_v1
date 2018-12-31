
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';

class RecipePage extends StatelessWidget{

  final Function(ProfileType) _showOptions;
  final double _margin; 
  final Profile _profile;
  final bool _isEditing;

  // Sets a String and Value in the Parent profie
  final Function(String , dynamic) _setProfileItemValue;

  RecipePage(this._profile, this._margin, this._setProfileItemValue, this._showOptions, this._isEditing);

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
              ProfileInputCardWithAttribute(
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
              ProfileInputCardWithAttribute(
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
              ProfileInputCardWithAttribute(
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
              Card(child: Container(margin: EdgeInsets.all(5.0), child: Row(children: <Widget>[
                TextFieldItemWithInitalValue(
                  _profile.getProfileItem(DatabaseIds.time),
                  (time) { _setProfileItemValue( DatabaseIds.time, time);},
                  100.0, 
                  _isEditing)],)),),

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
                        
                        NotesCard(
                        StringLabels.descriptors,
                        _profile.getProfileItemValue(
                             DatabaseIds.descriptors),
                        (text) {_setProfileItemValue( DatabaseIds.descriptors, text);},
                        _isEditing), 
                      ],
                    )
                  ],
                ),
              ),
          ],
            );
      }
}