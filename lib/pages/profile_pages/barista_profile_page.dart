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
import '../../data/profile.dart';
import '../../data/strings.dart';
import '../../widgets/custom_widgets.dart';
import '../../widgets/profile_page_widgets.dart';


class BaristaPage extends StatefulWidget {
  final double _margin;
  final Profile _profile;

// Sets a String and Value in the Parent profie
  final Function(String, dynamic) _setProfileItemValue;

  BaristaPage(this._profile, this._margin, this._setProfileItemValue);

  _BaristaPageState createState() => new _BaristaPageState();
}

class _BaristaPageState extends State<BaristaPage> {
  final double _padding = 20.0;
  final double _margin = 10.0;
  Profile _profile;

  @override
  void initState() {
    _profile = widget._profile;
    super.initState();
  }

  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[

      /// Details
      BaristaDetailsCard(
        (name) {widget._setProfileItemValue(DatabaseIds.name, name);},
        (level) {widget._setProfileItemValue(DatabaseIds.burrs, level);},
        _profile.getProfileItemValue(DatabaseIds.name),
        _profile.getProfileItemValue(DatabaseIds.level),
      ),

      /// Notes
      
      NotesCard(StringLabels.notes,
          _profile.getProfileItemValue( DatabaseIds.method),
          (text) {
        _profile.setProfileItemValue( DatabaseIds.method, text);
      })
    ]);
  }
}

class BaristaDetailsCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 150.0;
  final Function(String) _name;
  final Function(String) _level;
  String _nameValue;
  String _levelValue;

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
              TextFieldWithInitalValue(TextInputType.text, StringLabels.name, StringLabels.enterNickname,
               _nameValue, (value){ _level(value);}),   

              /// Level
              TextFieldWithInitalValue(TextInputType.text, StringLabels.level, StringLabels.enterLevel,
               _nameValue, (value){ _level(value);}),  

            ],
          ),
        ],
      ),
    ));
  }
}
