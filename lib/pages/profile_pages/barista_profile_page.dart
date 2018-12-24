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


  // Sets a String and Value in the Parent profie
  final Function(String, dynamic) _setProfileItemValue;

  BaristaPage(this._profile, this._margin, this._setProfileItemValue);

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
      ),

      /// Notes
      NotesCard(StringLabels.notes,
          _profile.getProfileItemValue( DatabaseIds.notes),
          (text) {
        _profile.setProfileItemValue( DatabaseIds.notes, text);
      })
    ]);
  }
}

class BaristaDetailsCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final Function(String) _name;
  final Function(String) _level;
  final Item _nameValue;
  final Item _levelValue;

  BaristaDetailsCard(
    this._name,
    this._level,
    this._nameValue,
    this._levelValue,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(_padding),
      margin: EdgeInsets.all(_margin),
      child: Column(
        children: <Widget>[
          ///Row 1
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              
              /// Name
              TextFieldItemWithInitalValue(_nameValue,
               (value){ _name(value);},  100.0),   

              /// Level
              TextFieldItemWithInitalValue( _levelValue,
               (value){ _level(value);}, 100.0),  

            ],
          ),
        ],
      ),
    ));
  }
}
