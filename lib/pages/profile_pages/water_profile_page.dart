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


class WaterPage extends StatefulWidget{

final Function(String) _showOptions;
final double _margin; 
final Profile _profile;

// Sets a String and Value in the Parent profie
final Function(String , dynamic) _setProfileItemValue;


  WaterPage(this._profile, this._margin, this._setProfileItemValue, this._showOptions);

_WaterPageState createState() => new _WaterPageState();
}


class _WaterPageState extends State<WaterPage> {
  
 ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[

                  DateInputCard(StringLabels.dateTested,
                  widget._profile.getProfileItemValue(itemDatabaseId: DatabaseIds.date),
                  (dateTime){widget._setProfileItemValue( DatabaseIds.date, dateTime);}),

                  WaterDetailsCard(
                    (totalPpm){widget._setProfileItemValue( DatabaseIds.ppm, totalPpm);},
                    (ghPpm){widget._setProfileItemValue( DatabaseIds.gh, ghPpm);},
                    (khPpm){widget._setProfileItemValue( DatabaseIds.kh, khPpm);},
                    (pH){widget._setProfileItemValue( DatabaseIds.ph, pH);}
                    )

    ]);
    }
}

class WaterDetailsCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  final Function(String) _totalPpm;
  final Function(String) _ghPpm;
  final Function(String) _khPpm;
  final Function(String) _pH;


WaterDetailsCard(this._totalPpm, this._ghPpm, this._khPpm, this._pH);

 @override
  Widget build(BuildContext context) {
    return Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[

          ///Total ppm
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                    labelText: StringLabels.ppm,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _totalPpm,
                            )),

          ///gh Ppm
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                    labelText: StringLabels.gh,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _ghPpm,
                            )),                  
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[

          /// kH
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                    labelText: StringLabels.kh,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _khPpm,
                            )),
          /// pH
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                    labelText: StringLabels.ph,
                    hintText: StringLabels.enterDescription,
                              ),
                              onChanged: _pH,
                            )),                  
        ],),
    ],),)
    );
}
}
