import '../../data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../database_functions.dart';
import '../../widgets/profile_page_widgets.dart';
import '../../data/profile.dart';

class EquipmentPage extends StatefulWidget {
  final double _margin;
  final Profile _profile;

// Sets a String and Value in the Parent profie
  final Function(String, dynamic) _setProfileItemValue;

  EquipmentPage(this._profile, this._margin, this._setProfileItemValue);

  _EquipmentPageState createState() => new _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
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
      EquipmentDetailsCard(
        (name) {widget._setProfileItemValue(DatabaseIds.equipmentId, name);},
        (type) {widget._setProfileItemValue(DatabaseIds.type, type);},
        (make) {widget._setProfileItemValue(DatabaseIds.equipmentMake, make);},
        (model) {widget._setProfileItemValue(DatabaseIds.equipmentModel, model);},
      ),

      /// Notes
      NotesCard(StringLabels.method,
          _profile.getProfileItemValue( DatabaseIds.method),
          (text) {
        _profile.setProfileItemValue( DatabaseIds.method, text);
      })
    ]);
  }
}

class EquipmentDetailsCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 150.0;
  final Function(String) _name;
  final Function(String) _type;
  final Function(String) _make;
  final Function(String) _model;

  EquipmentDetailsCard(
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

              /// Type
              Container(
                  width: _textFieldWidth,
                  child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      labelText: StringLabels.type,
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
