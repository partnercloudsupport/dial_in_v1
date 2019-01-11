import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/item.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';


class EquipmentPage extends StatelessWidget {
  final double _margin;
  final Profile _profile;
  final bool _isEditing;
  final Function(Item) _showPicker;

// Sets a String and Value in the Parent profie
  final Function(String, dynamic) _setProfileItemValue;

  EquipmentPage(this._profile, this._margin, this._setProfileItemValue, this._isEditing, this._showPicker);

  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[

      /// Details
      EquipmentDetailsCard(
        (name) {_setProfileItemValue(DatabaseIds.equipmentId, name);},
        _showPicker,
        (make) {_setProfileItemValue(DatabaseIds.equipmentMake, make);},
        (model) {_setProfileItemValue(DatabaseIds.equipmentModel, model);},
        _profile.getProfileItem(DatabaseIds.equipmentId),
        _profile.getProfileItem(DatabaseIds.type),
        _profile.getProfileItem(DatabaseIds.equipmentMake),
        _profile.getProfileItem(DatabaseIds.equipmentModel),
        _isEditing
      ),

      /// Notes
      NotesCard(StringLabels.method,
          _profile.getProfileItemValue( DatabaseIds.method),
          (text) {_profile.setProfileItemValue( DatabaseIds.method, text);},
          _isEditing)
    ]);
  }
}

class EquipmentDetailsCard extends StatelessWidget {
  final double _padding = 5.0;
  final double _margin = 5.0;
  final double _textFieldWidth = 140.0;
  final Function(String) _name;
  final Function(Item) _type;
  final Function(String) _make;
  final Function(String) _model;
  final Item _nameValue;
  final Item _typeValue;
  final Item _makeValue;
  final Item _modelValue;
  final bool _isEditing;

  EquipmentDetailsCard(
    /// Functions
    this._name, this._type, this._make, this._model,
    /// Values
    this._nameValue,this._typeValue,this._makeValue,this._modelValue,
    /// Editing
    this._isEditing

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
              /// Name
              TextFieldItemWithInitalValue(
               _nameValue, (value){ _name(value);}, _textFieldWidth, _isEditing), 

              /// Type
              PickerTextField(
               _typeValue, (value){ _type(value);}, _textFieldWidth, _isEditing), 

            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              /// Make
              TextFieldItemWithInitalValue(
               _makeValue, (value){ _make(value);}, _textFieldWidth, _isEditing),

              /// Model
              TextFieldItemWithInitalValue(
               _modelValue, (value){ _model(value);}, _textFieldWidth, _isEditing),
            ],
          ),
        ],
      ),
    ));
  }
}
