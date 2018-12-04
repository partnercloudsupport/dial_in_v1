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

class GrinderPage extends StatefulWidget {
  final double _margin;
  final Profile _profile;

// Sets a String and Value in the Parent profie
  final Function(String, dynamic) _setProfileItemValue;

  GrinderPage(this._profile, this._margin, this._setProfileItemValue);

  _GrinderPageState createState() => new _GrinderPageState();
}

class _GrinderPageState extends State<GrinderPage> {
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
      GrinderDetailsCard(
        (name) {widget._setProfileItemValue(DatabaseIds.grinderId, name);},
        (burrs) {widget._setProfileItemValue(DatabaseIds.burrs, burrs);},
        (make) {widget._setProfileItemValue(DatabaseIds.grinderMake, make);},
        (model) {widget._setProfileItemValue(DatabaseIds.grinderModel, model);},
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

class GrinderDetailsCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 150.0;
  final Function(String) _name;
  final Function(String) _type;
  final Function(String) _make;
  final Function(String) _model;

  GrinderDetailsCard(
    this._name,
    this._type,
    this._make,
    this._model,
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

              /// Burrs
              Container(
                  width: _textFieldWidth,
                  child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      labelText: StringLabels.burrs,
                      hintText: StringLabels.enterType,
                    ),
                    onChanged: (type) {
                      _type(type);
                    },
                  )),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /// Make
              Container(
                  width: _textFieldWidth,
                  child: TextField(
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        labelText: StringLabels.make,
                        hintText: StringLabels.enterDescription,
                      ),
                      onChanged: (make) {
                        _make(make);
                      })),

              /// Model
              Container(
                  width: _textFieldWidth,
                  child: TextField(
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        labelText: StringLabels.model,
                        hintText: StringLabels.enterDescription,
                      ),
                      onChanged: (model) {
                        _model(model);
                      })),
            ],
          ),
        ],
      ),
    ));
  }
}
