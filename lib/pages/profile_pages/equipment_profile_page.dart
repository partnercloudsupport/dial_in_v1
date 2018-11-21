import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        FontWeight,
        Icon,
        Icons,
        Navigator,
        RawMaterialButton,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        TextStyle,
        required;
import '../../data/profile.dart';
import '../../data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/images.dart';
import '../../data/functions.dart';
import '../../database_functions.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import '../../widgets/custom_widgets.dart';


class EquipmentProfilePage extends StatefulWidget {
  @required final bool isCopying;
  @required final bool isEditing;
  @required final bool isNew;
  @required final ProfileType type;
  @required final String referance;
  String appBarTitle;
  Profile _profile;

  EquipmentProfilePage(
      {this.isCopying, this.isEditing, this.isNew, this.type, this.referance}) {
    if (isNew || isCopying) {
      this.appBarTitle = StringLabels.newe +
          ' ' +
          Functions.getProfileTypeString(type) +
          ' ' +
          StringLabels.profile;
    }

    _profile = Functions.createBlankProfile(type);
  }

  EquipmentProfilePageState createState() => new EquipmentProfilePageState();
}

class EquipmentProfilePageState extends State<EquipmentProfilePage> {
  double _padding = 20.0;
  double _margin = 10.0;
  double _textFieldWidth = 120.0;
  double _cornerRadius = 20.0;
  Profile _profile;
  @required bool _isCopying;
  @required bool _isEditing;
  @required bool _isNew;
  

  void initState() {
    _isCopying = widget.isCopying;
    _isEditing = widget.isEditing;
    _isNew = widget.isNew;
    _profile = widget._profile;
    _profile = widget._profile;
    super.initState();
  }

  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.appBarTitle,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
        ),
        automaticallyImplyLeading: false,
        leading: _isEditing
            ? RawMaterialButton(
                child: Icon(Icons.cancel),
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                    print(_isEditing.toString());
                  });
                })
            : RawMaterialButton(
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
        actions: <Widget>[
          _isEditing
              ? RawMaterialButton(
                  child: Icon(Icons.save_alt),
                  onPressed: () {
                    Navigator.pop(context);
                    DatabaseFunctions.saveProfile(_profile);
                  },
                )
              : RawMaterialButton(
                  child: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                      print(_isEditing);
                    });
                  }),
        ],
      ),
      body: 

      ListView(
        children: <Widget>[
          Column(
            children: <Widget>[


              Row(children: <Widget>[

              /// Profile Image
              ProfileImage(Image.asset(Images.coffeeBeans)),

              Container(padding: EdgeInsets.all(_padding),margin: EdgeInsets.all(_margin),child: 
              Column(children: <Widget>[
              Text(StringLabels.public), 
              Switch(onChanged: (on){setState(() {_profile.isPublic = on;}); }, value: _profile.isPublic,),
              ],),),
              ]),

              FlatButton(
                onPressed: () {},
                child: Text(StringLabels.changeImage),
              ),

              WaterDetailsCard(
              (kh){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.kh, value: kh  );},
              (gh){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.gh, value: gh  );},
              (totalPpm){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.ppm, value: totalPpm  );},
              (dateTested){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.date, value: dateTested  );},
              (waterId){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.waterID, value: waterId  );},
              (ph){_profile.setProfileItemValue(itemDatabaseId: DatabaseIds.ph, value: ph  );})
              ],
          )
        ],
      ),
      );}
}

class WaterDetailsCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  final Function(String) _waterId;
  final Function(String) _dateTested;
  final Function(String) _totalPpm;
  final Function(String) _gh;
  final Function(String) _kh;
  final Function(String) _ph;

  WaterDetailsCard(this._kh, this._gh, this._totalPpm, this._dateTested, this._waterId, this._ph);

 @override
  Widget build(BuildContext context) {
    return Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        Text(StringLabels.originDetails, style: Theme.of(context).textTheme.title,),
        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          /// Name
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.name,
                    hintText: StringLabels.enterNickname,
                              ),
                              onChanged: _waterId,
                            )),
          /// Date
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.dateTested,
                    hintText: StringLabels.setDate,
                              ),
                              onChanged: _dateTested,
                            )),                  
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          /// ppm
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.ppm,
                    hintText: StringLabels.enterValue,
                              ),
                              onChanged: _totalPpm,
                            )),
          /// gH
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.gh,
                    hintText: StringLabels.enterValue,
                              ),
                              onChanged: _gh,
                            )),                  
        ],),

        ///Row 3
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          /// kH
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.kh,
                    hintText: StringLabels.enterValue,
                              ),
                              onChanged: _kh,
                            )),
          ///pH
          Container(width: _textFieldWidth,
                    child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                    labelText: StringLabels.ph,
                    hintText: StringLabels.enterValue,
                              ),
                              onChanged: _ph,
                            )),
               
        ],)
    ],),)
    );
}
}