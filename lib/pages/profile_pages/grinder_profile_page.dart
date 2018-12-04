import '../../data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../database_functions.dart';
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
        _profile.getProfileItemValue(DatabaseIds.name),
        _profile.getProfileItemValue(DatabaseIds.burrs),        
        _profile.getProfileItemValue(DatabaseIds.grinderMake),        
        _profile.getProfileItemValue(DatabaseIds.grinderModel),        
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
  final Function(String) _burrs;
  final Function(String) _make;
  final Function(String) _model;
  final String _nameValue;
  final String _typeValue;
  final String _makeValue;
  final String _modelValue;

  GrinderDetailsCard(
    /// Functions
    this._name,this._burrs,this._make,this._model,
    /// Variables
    this._nameValue, this._typeValue, this._makeValue, this._modelValue
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
              TextFieldWithInitalValue(TextInputType.text, StringLabels.make, StringLabels.enterDescription,
               _nameValue, (value){ _name(value);}),

              /// Burrs
              TextFieldWithInitalValue(TextInputType.text, StringLabels.make, StringLabels.enterDescription,
               _nameValue, (value){_burrs(value);}),

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
