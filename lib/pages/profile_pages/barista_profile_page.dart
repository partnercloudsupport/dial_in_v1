import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/item.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page_model.dart';


class BaristaPage extends StatelessWidget {

  // Sets a String and Value in the Parent profie
  final Function(String, dynamic) _setProfileItemValue;

  BaristaPage();

  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {

    ScopedModelDescendant(builder: (BuildContext context,_, ProfilePageModel model) =>

     StreamBuilder<Profile>(
            stream: model.profileStream,
            builder: (BuildContext context, AsyncSnapshot<Profile> snapshot){

    new Column(children: <Widget>[

      /// Details
      BaristaDetailsCard(),

      /// Notes
      NotesCard(StringLabels.notes,
          _profile.getItemValue( DatabaseIds.notes),
          (text) {
        _profile.setItemValue( DatabaseIds.notes, text);},
        _isEditing)
    ]);
  }
}

class BaristaDetailsCard extends StatelessWidget {

  final double _padding = 5.0;
  final double _margin = 5.0;
  final double _textFieldWidth = 150.0;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(padding: EdgeInsets.all(_padding),margin: EdgeInsets.all(_margin),
      child: Column(
        children: <Widget>[
          ///Row 1
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              
              /// Name
              TextFieldItemWithInitalValue(_nameValue,
               (value){ _name(value);},  _textFieldWidth,_isEditing),   

              /// Level
              TextFieldItemWithInitalValue( _levelValue,
               (value){ _level(value);}, _textFieldWidth,_isEditing),  

            ],
          ),
        ],
      )
    ));
  }
}
