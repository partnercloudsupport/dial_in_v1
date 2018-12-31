import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/item.dart';

class GrinderPage extends StatelessWidget {
  final double _margin;
  final Profile _profile;
  final bool _isEditing;

// Sets a String and Value in the Parent profie
  final Function(String, dynamic) _setProfileItemValue;

  GrinderPage(this._profile, this._margin, this._setProfileItemValue, this._isEditing);

  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[

      /// Details
      GrinderDetailsCard(
        (name) {_setProfileItemValue(DatabaseIds.grinderId, name);},
        (burrs) {_setProfileItemValue(DatabaseIds.burrs, burrs);},
        (make) {_setProfileItemValue(DatabaseIds.grinderMake, make);},
        (model) {_setProfileItemValue(DatabaseIds.grinderModel, model);},
        _profile.getProfileItem(DatabaseIds.grinderId),
        _profile.getProfileItem(DatabaseIds.burrs),        
        _profile.getProfileItem(DatabaseIds.grinderMake),        
        _profile.getProfileItem(DatabaseIds.grinderModel),
        _isEditing        
      ),

      /// Notes
      NotesCard(StringLabels.notes,
          _profile.getProfileItemValue( DatabaseIds.notes),
          (text) { _profile.setProfileItemValue( DatabaseIds.notes, text);},
          _isEditing)
    ]);
  }
}

class GrinderDetailsCard extends StatelessWidget {
  final double _padding = 5.0;
  final double _margin = 5.0;
  final double _textFieldWidth = 140.0;
  final Function(String) _name;
  final Function(String) _burrs;
  final Function(String) _make;
  final Function(String) _model;
  final Item _nameValue;
  final Item _burrsValue;
  final Item _makeValue;
  final Item _modelValue;
  final bool _isEditing;

  GrinderDetailsCard(
    /// Functions
    this._name,this._burrs,this._make,this._model,
    /// Variables
    this._nameValue, this._burrsValue, this._makeValue, this._modelValue,
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
              TextFieldItemWithInitalValue(_nameValue,
              (value){ _name(value);}, _textFieldWidth, _isEditing),

              /// Burrs
              TextFieldItemWithInitalValue(_burrsValue,
              (value){_burrs(value);}, _textFieldWidth, _isEditing),

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
               _modelValue, (value){ _model(value);} , _textFieldWidth, _isEditing),

            ],
          ),
        ],
      ),
    ));
  }
}
