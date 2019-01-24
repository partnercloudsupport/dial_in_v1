
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/widgets/profile_page_widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/item.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page_model.dart';


class RecipePage extends StatefulWidget {

  _RecipePageState createState() => _RecipePageState();

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

  @override
  Widget build(BuildContext context) {
    return  

    ScopedModelDescendant<ProfilePageModel>
              ( rebuildOnChange: true, builder: (BuildContext context, _ ,ProfilePageModel model) {

    return

     StreamBuilder<Profile>(
            stream: model.profileStream,
            builder: (BuildContext context, AsyncSnapshot<Profile> snapshot){
   
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
        snapshot.data.getProfileProfile(ProfileType.coffee),
        StringLabels.rested,
        snapshot.data.getDaysRested().toString() + ' days'),

    ///Barista
      ProfileInputCard(snapshot.data.getProfileProfile(ProfileType.barista),),

    // /// Water
      ProfileInputCardWithAttribute
      ( snapshot.data.getProfileProfile(ProfileType.water), snapshot.data.getItem(DatabaseIds.temparature)),

    // /// Grinder
      ProfileInputCardWithAttribute
      ( snapshot.data.getProfileProfile(ProfileType.grinder), snapshot.data.getItem(DatabaseIds.grindSetting)),

    // /// Equipment
      ProfileInputCardWithAttribute
      ( snapshot.data.getProfileProfile(ProfileType.equipment), snapshot.data.getItem(DatabaseIds.preinfusion)),

      /// Ratio card /// TODO fix
      RatioCard(),

      /// Time
      Card(child: Container(margin: EdgeInsets.all(10.0), child: Row(children: <Widget>[
        
          TimePickerTextField(
          snapshot.data.getItem(DatabaseIds.time),
          (item) => PopUps.showPickerMenu(item, context, model),
          100.0, 
          ),

          ],)),),

      /// Extraction and TDS
      /// TODO
      // TdsAndExtractionCard(),

      /// Notes
      NotesCard( snapshot.data.getItem( DatabaseIds.notes )),

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
                (value) { model.setProfileItemValue( DatabaseIds.strength, value.toString());},
                ),

                Divider(),

              ScoreSlider(
                StringLabels.balance,
                double.parse(snapshot.data.getItemValue(DatabaseIds.balance)),
                (value) { model.setProfileItemValue( DatabaseIds.balance, value.toString());},
                ),

              Divider(),

              ScoreSlider(
                StringLabels.flavour,
                double.parse(snapshot.data.getItemValue(DatabaseIds.flavour)),
                (value) { model.setProfileItemValue( DatabaseIds.flavour, value.toString());},
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
                double.parse(snapshot.data.getItemValue(DatabaseIds.afterTaste)),
                (value) {model.setProfileItemValue( DatabaseIds.afterTaste, value.toString());},
                ),

              Padding(padding: EdgeInsets.all(20.0)),

              Text('Total score ${snapshot.data.getTotalScore().toInt().toString()} / 50', style: Theme.of(context).textTheme.display4)
              /// End of score   
          
          ],
        ),
        ),
      ),
        NotesCard(snapshot.data.getItem(DatabaseIds.descriptors)),
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

