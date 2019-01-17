import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/item.dart';

class BaristaPage extends StatelessWidget {
  final double _margin;
  final Profile _profile;
  final double _padding = 20.0;
  final bool _isEditing;


  // Sets a String and Value in the Parent profie
  final Function(String, dynamic) _setProfileItemValue;

  BaristaPage(this._profile, this._margin, this._setProfileItemValue, this._isEditing);

  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[

      /// Details
      BaristaDetailsCard(
        (name) {_setProfileItemValue(DatabaseIds.name, name);},
        (level) {_setProfileItemValue(DatabaseIds.level, level);},
        _profile.getProfileItem(DatabaseIds.name),
        _profile.getProfileItem(DatabaseIds.level),
        _isEditing
      ),

      /// Notes
      NotesCard(StringLabels.notes,
          _profile.getItemValue( DatabaseIds.notes),
          (text) {
        _profile.setItemValue( DatabaseIds.notes, text);},
        _isEditing)
    ]);
  }
}

class BaristaDetailsCard extends StatelessWidget {
  final double _padding = 5.0;
  final double _margin = 5.0;
  final double _textFieldWidth = 150.0;
  final Function(String) _name;
  final Function(String) _level;
  final Item _nameValue;
  final Item _levelValue;
  final bool _isEditing;

  BaristaDetailsCard(
    this._name,
    this._level,
    this._nameValue,
    this._levelValue,
    this._isEditing
  );

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(padding: EdgeInsets.all(_padding),margin: EdgeInsets.all(_margin),
      child: Column(
        children: <Widget>[
          ///Row 1
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              
              /// Name
              TextFieldItemWithInitalValue(_nameValue,
               (value){ _name(value);},  _textFieldWidth,_isEditing),   

              /// Level
              TextFieldItemWithInitalValue( _levelValue,
               (value){ _level(value);}, _textFieldWidth,_isEditing),  

            ],
          ),
        ],
      )
    ));
  }
}
