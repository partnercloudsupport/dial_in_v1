import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/item.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';


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
        _profile.getProfileItem(DatabaseIds.equipmentId),
        _profile.getProfileItem(DatabaseIds.type),
        _profile.getProfileItem(DatabaseIds.equipmentMake),
        _profile.getProfileItem(DatabaseIds.equipmentModel),
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
  final Function(String) _name;
  final Function(String) _type;
  final Function(String) _make;
  final Function(String) _model;
  final Item _nameValue;
  final Item _typeValue;
  final Item _makeValue;
  final Item _modelValue;

  EquipmentDetailsCard(
    /// Functions
    this._name, this._type, this._make, this._model,
    /// Values
    this._nameValue,this._typeValue,this._makeValue,this._modelValue
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
              TextFieldItemWithInitalValue(
               _nameValue, (value){ _name(value);}), 

              /// Type
              TextFieldItemWithInitalValue(
               _typeValue, (value){ _type(value);}), 

            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              /// Make
              TextFieldItemWithInitalValue(
               _makeValue, (value){ _make(value);}),

              /// Model
              TextFieldItemWithInitalValue(
               _modelValue, (value){ _model(value);}),
            ],
          ),
        ],
      ),
    ));
  }
}
