import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/item.dart';

class WaterPage extends StatelessWidget{

final Profile _profile;
final double _padding = 20.0;
final bool _isEditing;

// Sets a String and Value in the Parent profie
final Function(String , dynamic) _setProfileItemValue;

  WaterPage(this._profile, this._setProfileItemValue, this._isEditing);

  /// UI Build
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[

                  /// Name
                  Row
                  (mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  TextFieldItemWithInitalValue
                  (_profile.getProfileItem(DatabaseIds.waterID),
                  (name){_setProfileItemValue( DatabaseIds.waterID, name);}
                  , 200.0,_isEditing)
                   ]) , 
                  
                  /// Date
                  DateInputCard(StringLabels.dateTested,
                  _profile.getProfileItemValue( DatabaseIds.date),
                  (dateTime){_setProfileItemValue( DatabaseIds.date, dateTime);}, _isEditing),

                  /// Details
                  WaterDetailsCard(
                    (totalPpm){_setProfileItemValue( DatabaseIds.ppm, totalPpm);},
                    (ghPpm){_setProfileItemValue( DatabaseIds.gh, ghPpm);},
                    (khPpm){_setProfileItemValue( DatabaseIds.kh, khPpm);},
                    (pH){_setProfileItemValue( DatabaseIds.ph, pH);},
                    _profile.getProfileItem( DatabaseIds.ppm),
                    _profile.getProfileItem( DatabaseIds.gh),
                    _profile.getProfileItem( DatabaseIds.kh),
                    _profile.getProfileItem( DatabaseIds.ph),
                    _isEditing
                    ),

                  // /// Notes
                   NotesCard(StringLabels.notes,
                    _profile.getProfileItemValue( DatabaseIds.notes),
                    (text){_profile.setProfileItemValue( DatabaseIds.notes, text);},
                    _isEditing) 
    ]);
    }
}

class WaterDetailsCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 140.0;
  final Function(String) _totalPpm;
  final Function(String) _ghPpm;
  final Function(String) _khPpm;
  final Function(String) _pH;
  final Item _totalPpmItem;
  final Item _ghPpmItem;
  final Item _khPpmItem;
  final Item _pHItem;
  final bool _isEditing;


WaterDetailsCard(
  ///Functions
  this._totalPpm, this._ghPpm, this._khPpm, this._pH,
  /// Items 
  this._totalPpmItem, this._ghPpmItem, this._khPpmItem, this._pHItem,
  /// Editing
  this._isEditing
  );

 @override
  Widget build(BuildContext context) {
    return Card(child:
     Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin),
     child: Column(children: <Widget>[

        ///Row 1
        Row
        (mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ///Total ppm
          TextFieldItemWithInitalValue( _totalPpmItem,(value){ _totalPpm(value);}, _textFieldWidth,_isEditing ),

          ///gh Ppm
          TextFieldItemWithInitalValue( _ghPpmItem,(value){ _ghPpm(value);}, _textFieldWidth, _isEditing),               

        ]),

        ///Row 2
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         crossAxisAlignment: CrossAxisAlignment.center, 
         children: <Widget>[

          /// kH
          TextFieldItemWithInitalValue( _khPpmItem,(value){ _khPpm(value);}, _textFieldWidth, _isEditing),

          /// pH
          TextFieldItemWithInitalValue( _pHItem,(value){ _pH(value);}, _textFieldWidth, _isEditing),

            ],
          ),
        ],
      )
    )
    );
  }
}
