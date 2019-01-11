
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:flutter/services.dart';
import 'package:dial_in_v1/data/item.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';

class RecipePage extends StatefulWidget {

  _RecipePageState createState() => _RecipePageState();

  final double _margin; 
  final Function(ProfileType) _showOptions;
  final Profile _profile;
  final bool _isEditing;
  final ScrollController _scrollController;

  // Sets a String and Value in the Parent profie
  final Function(String , dynamic) _setProfileItemValue;

  RecipePage(this._profile, this._margin, this._setProfileItemValue, this._showOptions, this._isEditing, this._scrollController);
}

class _RecipePageState extends State<RecipePage> {

  Stopwatch stopwatch = new Stopwatch();
  Timer timer = Timer(Duration(milliseconds:1000), (){},);
  int time;
  int mins;
  int sec;

  void startWatch() {
  timer = new Timer.periodic(new Duration(milliseconds:1000), updateTime);
  }

  void stopWatch() {
    setState(() {
      timer.cancel();
    });
  }

  void resetWatch() {
    setState(() {
      time = 0;
      timer.cancel();
    });
  }

  void updateTime(Timer timer){
       
      print('time is $time ${timer.isActive}');

      setState(() {
           time ++;
      });
  }

  void showPickerMenu(Item item, BuildContext context){

    showModalBottomSheet(context: context, builder: (BuildContext context){
      // widget._scrollController.animateTo(widget._scrollController.position.pixels - 300,curve: Curves.easeInOut, duration: Duration(seconds: 1) );
      return TimePicker(item, widget._setProfileItemValue);
      }
    );
    // .then((v){ widget._scrollController.animateTo(widget._scrollController.position.pixels + 300,curve: Curves.easeInOut, duration: Duration(seconds: 1) );
    // });
  }

/// TODO
  // void _estimateBrewRatio(BrewRatioType type){
  //   setState(() {  
  //   if(type == BrewRatioType.doseYield){
  //     int dose = Functions.getIntValue(widget._profile.getProfileItemValue(DatabaseIds.brewingDose));
  //     int brewWeight = Functions.getIntValue(widget._profile.getProfileItemValue(DatabaseIds.brewWeight));
  //     int result = brewWeight - dose;
  //     widget._setProfileItemValue(DatabaseIds.yielde, result.toString());
      
  //   }else{
  //     int dose = Functions.getIntValue(widget._profile.getProfileItemValue(DatabaseIds.brewingDose));
  //     int yielde = Functions.getIntValue(widget._profile.getProfileItemValue(DatabaseIds.yielde));
  //     int result = dose + yielde;
  //     widget._setProfileItemValue(DatabaseIds.brewWeight, result.toString());
  //   }
  //    });
  // }


  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return  

    ScopedModelDescendant<RatioModel>
              ( rebuildOnChange: true, builder: (BuildContext context, _ ,RatioModel model) {
    
    model.updateValues(widget._profile);

    return
    Column(children: <Widget>[ 

    /// Date
      DateTimeInputCard(
          StringLabels.date,
          widget._profile.getProfileItemValue( DatabaseIds.date),
          (dateTime)
          {if (dateTime != null){ widget._setProfileItemValue( DatabaseIds.date, dateTime);}},
            widget._isEditing),

    ///Coffee
      ProfileInputWithDetailsCard(
        widget._isEditing,
        widget._profile.getProfileProfile(ProfileType.coffee),
        StringLabels.rested,
        widget._profile.getDaysRested().toString() + ' days',
        (){widget._showOptions(ProfileType.coffee);},),

    ///Barista
      ProfileInputCard(
        widget._isEditing,
        widget._profile.getProfileProfile(ProfileType.barista),
        (){widget._showOptions(ProfileType.barista);},),

    /// Water
      ProfileInputCardWithAttribute(
          widget._isEditing,
          profile: widget._profile.getProfileProfile(ProfileType.water),
          keyboardType: TextInputType.number,
          onAttributeTextChange: (text) {
            widget._setProfileItemValue( DatabaseIds.temparature, text);
          },
          onProfileTextPressed: () {
            widget._showOptions(ProfileType.water);
          },
          attributeTextfieldText: widget._profile.getProfileItemValue(
                DatabaseIds.temparature),
          attributeHintText: StringLabels.enterValue,
          attributeTitle: StringLabels.degreeC,
          ),

    /// Grinder
      ProfileInputCardWithAttribute(
          widget._isEditing,
          profile: widget._profile.getProfileProfile(ProfileType.grinder),
          onAttributeTextChange: (text) {
            widget._setProfileItemValue(DatabaseIds.grindSetting, text);
          },
          onProfileTextPressed: () {
            widget._showOptions(ProfileType.grinder);
          },
          attributeTextfieldText: widget._profile.getProfileItemValue(
                DatabaseIds.grindSetting),
          attributeHintText: StringLabels.enterValue,
          attributeTitle: StringLabels.setting,
          keyboardType: TextInputType.number,
      ),

    /// Equipment
      ProfileInputCardWithAttribute(
          widget._isEditing,
          profile: widget._profile.getProfileProfile(ProfileType.equipment),
          onAttributeTextChange: (text) {
            widget._setProfileItemValue(DatabaseIds.preinfusion, text);
          },
          onProfileTextPressed: () {
            widget._showOptions(ProfileType.equipment);
          },
          attributeTextfieldText: widget._profile.getProfileItemValue(
                DatabaseIds.preinfusion),
          attributeHintText: StringLabels.enterValue,
          attributeTitle: StringLabels.preinfusion,
      ),

      /// Ratio card
      RatioCard(
        widget._profile,
        (dose) {widget._setProfileItemValue( DatabaseIds.brewingDose, dose);},  
        (yielde) {widget._setProfileItemValue( DatabaseIds.yielde, yielde);},
        (brewWeight) { widget._setProfileItemValue( DatabaseIds.brewWeight, brewWeight);},
        widget._isEditing,
      ),

      /// Time
      Card(child: Container(margin: EdgeInsets.all(10.0), child: Row(children: <Widget>[
        
          TimePickerTextField(
          widget._profile.getProfileItem(DatabaseIds.time),
          (item) => showPickerMenu(item, context),
          100.0, 
          widget._isEditing)

          ],)),),

      /// Extraction and TDS
      TwoTextfieldCard(
        (tds) { widget._setProfileItemValue( DatabaseIds.tds, tds);},
        widget._profile.getProfileItem(DatabaseIds.tds),
        widget._isEditing,
        widget._profile.getExtractionYield() 
      ),

      /// Notes
      NotesCard(
          StringLabels.notes,
          widget._profile.getProfileItemValue(
                DatabaseIds.notes),
          (notes) {widget._setProfileItemValue( DatabaseIds.notes, notes);},
          widget._isEditing),

      ///Score Section
      Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(widget._margin),
              padding: EdgeInsets.all(widget._margin),
              child: Text(
                StringLabels.score,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Column(
              children: <Widget>[
                ScoreSlider(StringLabels.strength, 0.0,
                  (value) { widget._setProfileItemValue( DatabaseIds.strength, value.toString());},
                  widget._isEditing),

                ScoreSlider(StringLabels.balance, 0.0,
                  (value) { widget._setProfileItemValue( DatabaseIds.balance, value.toString());},
                  widget._isEditing),

                ScoreSlider(StringLabels.flavour, 0.0,
                  (value) { widget._setProfileItemValue( DatabaseIds.flavour, value.toString());},
                  widget._isEditing),

                ScoreSlider(StringLabels.body, 0.0,
                  (value) {widget._setProfileItemValue( DatabaseIds.body, value.toString());},
                  widget._isEditing),

                ScoreSlider(StringLabels.afterTaste, 0.0,
                  (value) {widget._setProfileItemValue( DatabaseIds.afterTaste, value.toString());},
                  widget._isEditing),

                /// End of score   
                
              ],
            )
          ],
        ),
      ),
        NotesCard(
                StringLabels.descriptors,
                widget._profile.getProfileItemValue(
                      DatabaseIds.descriptors),
                (text) {widget._setProfileItemValue( DatabaseIds.descriptors, text);},
                widget._isEditing),
              ],
        );
    }
  );
  }
}


class TimePicker extends StatefulWidget {

  final Item item;
  final Function(String , dynamic) _setProfileItemValue;

  TimePicker(this.item, this._setProfileItemValue);
  

  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {

  bool stateInitialised = false;
  double _itemHeight = 40.0; 
  double _pickerHeight = 120.0;
  double _pickerWidth = 50.0;

  List< Widget> _minutes = new List<Widget>();
  List< Widget> _seconds = new List<Widget>();

  Stopwatch stopwatch = new Stopwatch();
  Timer timer = Timer(Duration(milliseconds:1000), (){},);
  int time = 0;
  int mins;
  int sec;
  bool timerIsActive = false;

  FixedExtentScrollController _minuteController;
  FixedExtentScrollController _secondController;  

  @override
  void initState() {
  mins = (Functions.getIntValue(widget.item.value)/60).floor();
  sec = Functions.getIntValue(widget.item.value) % 60;
    super.initState();
  }

  void startWatch() {
      setState(() {
        timerIsActive = true;
        timer = Timer.periodic(Duration(seconds:1),(Timer t) => updateTime(t));
            });
  }

  void stopWatch() {
    setState(() {
      timerIsActive = false;
      timer.cancel();
    });
  }

  void resetWatch() {
    setState(() {
      timerIsActive = false;
      time = 0;
      timer.cancel();
      _secondController.jumpToItem(0);
      _minuteController.jumpToItem(0);
    });
  }

  void updateTime(Timer timer){
       
      setState(() {
           time ++;
            mins = (time ~/ 60).toInt();
            sec = (time % 60);
   
            _minuteController.animateTo(
            mins * _itemHeight.toDouble(),
            duration: Duration(
            seconds: 1), curve: Curves.linear);

          if (time % 60 == 0){ _secondController.jumpToItem(mins);}
            else{
                _secondController.animateTo(
                sec * _itemHeight.toDouble(),
                duration: Duration(
                      seconds: 1), curve: Curves.linear);}
      }
      );
  }

  @override
    void dispose() {
      timer.cancel();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {

    if (stateInitialised == false){

      if (widget.item.inputViewDataSet != null && widget.item.inputViewDataSet.length > 0)
      {widget.item.inputViewDataSet[0]
      .forEach((itemText){_minutes.add(Center(child:Text(itemText.toString(), style: Theme.of(context).textTheme.display2,)));}
      );}

      if (widget.item.inputViewDataSet != null && widget.item.inputViewDataSet.length > 0)
      {widget.item.inputViewDataSet[1]
      .forEach((itemText){_seconds.add(Center(child:Text(itemText.toString(), style: Theme.of(context).textTheme.display2,)));}
      );}    

      _minuteController = new FixedExtentScrollController(initialItem: mins);
      _secondController = new FixedExtentScrollController(initialItem: sec);
      stateInitialised = true;

    }

    return Container(
       child: Container(child: SizedBox(height: 200.0, width: double.infinity, child: Column(children: <Widget>[

      Material(elevation: 5.0, shadowColor: Colors.black, color:Theme.of(context).accentColor, type:MaterialType.card, 
      child: Container(height: 40.0, width: double.infinity,
      child:
      Row(mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[

      MaterialButton(onPressed:() { setState(() {
                    timerIsActive ? stopWatch() :  startWatch(); 
            });},
      child: timerIsActive ? Icon(Icons.stop): Icon(Icons.play_arrow)),

      MaterialButton(onPressed:() { setState(() {
         resetWatch();}
         );},
      child: Icon(Icons.restore)),

      Expanded(child: Container(),),

      FlatButton(onPressed:() => Navigator.pop(context),
      child: Text('Done')),

      ],)
      )
      ),

  SizedBox(height: 160.0, width: double.infinity  ,child:
  Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,  
  children: <Widget>[

    /// Minutes picker
    Row(children: <Widget>[
      SizedBox(height: _pickerHeight, width: _pickerWidth ,
      child: CupertinoPicker(
        backgroundColor: Colors.transparent,
        scrollController: _minuteController,
        useMagnifier: true,
        onSelectedItemChanged:
          (value){ setState(() {
            mins = value;
            widget._setProfileItemValue(widget.item.databaseId, ((mins * 60) + sec).toString());
            });
          }, 
        itemExtent: _itemHeight,
        children: _minutes
        ),),
        Text('m')
    ],),

      Padding(padding: EdgeInsets.all(20.0)),

    /// Seconds picker
      Row(children: <Widget>[
          SizedBox(height: _pickerHeight, width: _pickerWidth  ,
      child: CupertinoPicker(
        backgroundColor:  Colors.transparent,
        scrollController: _secondController,
        useMagnifier: true,
        onSelectedItemChanged:
          (value){setState(() {      
            sec = value;
            widget._setProfileItemValue(widget.item.databaseId,  ((mins * 60) + sec).toString());
             });
          }, 
        itemExtent: _itemHeight,
        children: _seconds
        ),),
      Text('s'),

          ],
      )
  ],))
  ],) )
  )
  );}
}
  

