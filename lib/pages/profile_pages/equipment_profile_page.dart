import '../../data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../database_functions.dart';
import '../../widgets/profile_page_widgets.dart';
import '../../data/profile.dart';
import '../../widgets/custom_widgets.dart';


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
        _profile.getProfileItemValue(DatabaseIds.name),
        _profile.getProfileItemValue(DatabaseIds.type),
        _profile.getProfileItemValue(DatabaseIds.equipmentMake),
        _profile.getProfileItemValue(DatabaseIds.equipmentModel),
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
  final String _nameValue;
  final String _typeValue;
  final String _makeValue;
  final String _modelValue;

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
              TextFieldWithInitalValue(TextInputType.text, StringLabels.name, StringLabels.enterNickname,
               _nameValue, (value){ _name(value);}), 

              /// Type
              TextFieldWithInitalValue(TextInputType.text, StringLabels.type, StringLabels.enterName,
               _nameValue, (value){ _type(value);}), 

            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              /// Make
              TextFieldWithInitalValue(TextInputType.text, StringLabels.make, StringLabels.enterDescription,
               _nameValue, (value){ _make(value);}),

              /// Model
              TextFieldWithInitalValue(TextInputType.text, StringLabels.make, StringLabels.enterDescription,
               _nameValue, (value){ _make(value);}),
            ],
          ),
        ],
      ),
    ));
  }
}
