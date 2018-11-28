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

      ),

      /// Notes
      NotesCard(StringLabels.notes,
          _profile.getProfileItemValue(itemDatabaseId: DatabaseIds.method),
          (text) {
        _profile.setProfileItemValue(itemDatabaseId: DatabaseIds.method);
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

  BaristaDetailsCard(
    this._name,
    this._level,
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
              Container(
                  width: _textFieldWidth,
                  child: TextField(
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        labelText: StringLabels.name,
                        hintText: StringLabels.enterNickname,
                      ),
                      onChanged: (name) {
                        _name(name);
                      })),

              /// Level
              Container(
                  width: _textFieldWidth,
                  child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      labelText: StringLabels.level,
                      hintText: StringLabels.enterType,
                    ),
                    onChanged: (level) {
                      _level(level);
                    },
                  )),
            ],
          ),
        ],
      ),
    ));
  }
}