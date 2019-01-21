
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
import 'package:dial_in_v1/pages/profile_pages/profile_page_model.dart';


class RecipePage extends StatefulWidget {

  _RecipePageState createState() => _RecipePageState();

  
  final Function(ProfileType) _showOptions;
  // final ScrollController _scrollController;

  RecipePage(this._showOptions);
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
      return TimePicker(item,  );
      }
    );
   
  }

  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return  

    ScopedModelDescendant<ProfilePageModel>
              ( rebuildOnChange: true, builder: (BuildContext context, _ ,ProfilePageModel model) {


     StreamBuilder<Profile>(
            stream: model.profileStream,
            builder: (BuildContext context, AsyncSnapshot<Profile> snapshot){
    
    model.updateRatioValues();

    return
    Column(children: <Widget>[ 

    /// Date
      DateTimeInputCard(
          StringLabels.date,
          snapshot.data.getItemValue( DatabaseIds.date),
          (dateTime) {if (dateTime != null){ model.setProfileItemValue( DatabaseIds.date, dateTime);}},
          ),

    ///Coffee
      ProfileInputWithDetailsCard(
        widget._profile.getProfileProfile(ProfileType.coffee),
        StringLabels.rested,
        widget._profile.getDaysRested().toString() + ' days',
        (){widget._showOptions(ProfileType.coffee);},),

    ///Barista
      ProfileInputCard(
        snapshot.data.getProfileProfile(ProfileType.barista),
        widget._showOptions),

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
          attributeTextfieldText: widget._profile.getItemValue(
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
          attributeTextfieldText: widget._profile.getItemValue(
                DatabaseIds.grindSetting),
          attributeHintText: StringLabels.enterValue,
          attributeTitle: StringLabels.setting,
          keyboardType: TextInputType.number,
      ),

    /// Equipment
      ProfileInputCardWithAttribute(
          profile: widget._profile.getProfileProfile(ProfileType.equipment),
          onAttributeTextChange: (text) {
            widget._setProfileItemValue(DatabaseIds.preinfusion, text);
          },
          onProfileTextPressed: () {
            widget._showOptions(ProfileType.equipment);
          },
          attributeTextfieldText: widget._profile.getItemValue(
                DatabaseIds.preinfusion),
          attributeHintText: StringLabels.enterValue,
          attributeTitle: StringLabels.preinfusion,
          textFieldWidth: 200,
      ),

      /// Ratio card
      RatioCard(),

      /// Time
      Card(child: Container(margin: EdgeInsets.all(10.0), child: Row(children: <Widget>[
        
          TimePickerTextField(
          p._profile.getProfileItem(DatabaseIds.time),
          (item) => showPickerMenu(item, context),
          100.0, 
          )

          ],)),),

      /// Extraction and TDS
      TdsAndExtractionCard(
        (tds) { widget._setProfileItemValue( DatabaseIds.tds, tds);},
        widget._profile.getItem(DatabaseIds.tds),
        widget._isEditing,
        widget._profile.getExtractionYield() 
      ),

      /// Notes
      NotesCard(
          StringLabels.notes,
          widget._profile.getItemValue(
                DatabaseIds.notes),
          (notes) {widget._setProfileItemValue( DatabaseIds.notes, notes);},
          widget._isEditing),

      ///Score Section
      Card( child: Container(
              
              padding: EdgeInsets.all(50.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
        
                    Text(
                      StringLabels.score,
                      style: Theme.of(context).textTheme.title,
                      ),
                  
                      ScoreSlider(
                        StringLabels.strength,
                        double.parse(snapshot.data.getItemValue(DatabaseIds.strength)),
                        (value) { widget._setProfileItemValue( DatabaseIds.strength, value.toString());},
                        ),

                        Divider(),

                      ScoreSlider(
                        StringLabels.balance,
                        double.parse(snapshot.data.getItemValue(DatabaseIds.balance)),
                        (value) { widget._setProfileItemValue( DatabaseIds.balance, value.toString());},
                        ),

                      Divider(),

                      ScoreSlider(
                        StringLabels.flavour,
                        double.parse(snapshot.data.getItemValue(DatabaseIds.flavour)),
                        (value) { widget._setProfileItemValue( DatabaseIds.flavour, value.toString());},
                        ),

                      Divider(),


                      ScoreSlider(
                        StringLabels.body,
                        double.parse(snapshot.data.getItemValue(DatabaseIds.body)),
                        (value) {model.setProfileItemValue( DatabaseIds.body, value.toString());},
                        ),

                      Divider(),


                      ScoreSlider(
                        StringLabels.afterTaste,
                        double.parse(widget._profile.getItemValue(DatabaseIds.afterTaste)),
                        (value) {model.setProfileItemValue( DatabaseIds.afterTaste, value.toString());},
                        ),

                      Padding(padding: EdgeInsets.all(20.0)),

                      Text('Total score ${snapshot.data.getTotalScore().toInt().toString()} / 50', style: Theme.of(context).textTheme.display4)
                      /// End of score   
                  
          ],
        ),
        ),
      ),
        NotesCard(
                StringLabels.descriptors,
                snapshot.data.getItemValue(
                      DatabaseIds.descriptors),
                (text) {model.setProfileItemValue( DatabaseIds.descriptors, text);},
         ),
              ],
        );
    }
  );
               }
 );
  }
}


class TimePicker extends StatefulWidget {

  final Item item;

  TimePicker(this.item);
  

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
  Timer timer;
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
        timer = Timer.periodic(Duration(seconds:1),(Timer t) => setState(()=>updateTime(t)));
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
                  seconds: 1), curve: Curves.linear);
        }
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

    return 
    
     ScopedModelDescendant(builder: (BuildContext context,_, ProfilePageModel model) =>

     StreamBuilder<Profile>(
            stream: model.profileStream,
            builder: (BuildContext context, AsyncSnapshot<Profile> snapshot){
              
     return
              
    Container(
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
            model.setProfileItemValue(widget.item.databaseId, ((mins * 60) + sec).toString());
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
            model.setProfileItemValue(widget.item.databaseId,  ((mins * 60) + sec).toString());
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
  );
  }
     )
     );
}
}

