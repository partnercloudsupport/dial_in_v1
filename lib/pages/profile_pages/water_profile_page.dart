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
import '../../data/item.dart';



class WaterPage extends StatefulWidget{

final double _margin; 
final Profile _profile;

// Sets a String and Value in the Parent profie
final Function(String , dynamic) _setProfileItemValue;

  WaterPage(this._profile, this._margin, this._setProfileItemValue);

_WaterPageState createState() => new _WaterPageState();
}


class _WaterPageState extends State<WaterPage> {
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

                  /// Name
                  Container(margin: EdgeInsets.all(_margin),padding: EdgeInsets.all(_padding),
                  child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      labelText: StringLabels.name,
                      hintText: StringLabels.enterNickname,
                    ),
                    onChanged: (name){{widget._setProfileItemValue( DatabaseIds.waterID, name);}}),
                  ),

                  /// Date
                  DateInputCard(StringLabels.dateTested,
                  widget._profile.getProfileItemValue( DatabaseIds.date),
                  (dateTime){widget._setProfileItemValue( DatabaseIds.date, dateTime);}),

                  /// Details
                  WaterDetailsCard(
                    (totalPpm){widget._setProfileItemValue( DatabaseIds.ppm, totalPpm);},
                    (ghPpm){widget._setProfileItemValue( DatabaseIds.gh, ghPpm);},
                    (khPpm){widget._setProfileItemValue( DatabaseIds.kh, khPpm);},
                    (pH){widget._setProfileItemValue( DatabaseIds.ph, pH);},
                    _profile.getProfileItem( DatabaseIds.ppm),
                    _profile.getProfileItem( DatabaseIds.gh),
                    _profile.getProfileItem( DatabaseIds.kh),
                    _profile.getProfileItem( DatabaseIds.ph),
                    ),

                  /// Notes
                   NotesCard(StringLabels.notes,
                    _profile.getProfileItemValue( DatabaseIds.notes),
                    (text){_profile.setProfileItemValue( DatabaseIds.notes, text);}) 
    ]);
    }
}

class WaterDetailsCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 150.0;
  final Function(String) _totalPpm;
  final Function(String) _ghPpm;
  final Function(String) _khPpm;
  final Function(String) _pH;
  final Item _totalPpmItem;
  final Item _ghPpmItem;
  final Item _khPpmItem;
  final Item _pHItem;


WaterDetailsCard(
  ///Functions
  this._totalPpm, this._ghPpm, this._khPpm, this._pH,
  /// Items 
  this._totalPpmItem, this._ghPpmItem, this._khPpmItem, this._pHItem,
  );

 @override
  Widget build(BuildContext context) {
    return Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[

          ///Total ppm
          TextFieldItemWithInitalValue( _totalPpmItem,(value){ _totalPpm(value);}),

          ///gh Ppm
          TextFieldItemWithInitalValue( _ghPpmItem,(value){ _ghPpm(value);}),               
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[

          /// kH
          TextFieldItemWithInitalValue( _khPpmItem,(value){ _khPpm(value);}),

          /// pH
          TextFieldItemWithInitalValue( _pHItem,(value){ _pH(value);}),

          /// Notes                              
        ],),
    ],),)
    );
}
}
