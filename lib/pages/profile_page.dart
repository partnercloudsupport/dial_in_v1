import 'package:flutter/material.dart' show AppBar, BuildContext, FontWeight, Icon, Icons, Navigator, RawMaterialButton, Scaffold, State, StatefulWidget, Text, TextStyle, required;
import  '../data/profile.dart';
import '../data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/images.dart';
import '../widgets/custom_widgets.dart';

class ProfilePage extends StatefulWidget{

  @required bool isCopying;
  @required bool isEditing; 
  @required bool isNew;
  @required ProfileType type; 
  @required String referance;

  ProfilePage({this.isCopying, this.isEditing, this.isNew, this.type, this.referance}){
    


    






  
  }
  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{

  double _padding = 20.0;
  double _margin = 10.0;
  double _textFieldWidth = 120.0;
  double _cornerRadius = 20.0; 
  Widget _backCancelButton;
  Widget _saveEditButton;

  void initState() { 

  /// Set back button depending on state
  _backCancelButton =  widget.isEditing ? 
  RawMaterialButton(child: Text(StringLabels.cancel),onPressed:(){ widget.isEditing = false;} ,):  
  RawMaterialButton(child: Text(StringLabels.back),onPressed:(){ Navigator.pop(context); } ,);

  /// Set save button depending on state
  _saveEditButton =  widget.isEditing ? 
  RawMaterialButton(child: Text(StringLabels.save),onPressed:(){ print('big job');} ,):  
  RawMaterialButton(child: Text(StringLabels.edit),onPressed:(){ widget.isEditing = true; } ,);

  super.initState();
  }
 

///
/// UI Build
///
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(centerTitle: true, title: Text(StringLabels.profile, style: TextStyle( fontWeight: FontWeight.w700),), automaticallyImplyLeading: false,
      leading: _backCancelButton, 
      actions: <Widget>[ _saveEditButton  ],),
      body: ListView(children: <Widget>[

        Column(children: <Widget>[  

          /// Profile Image
          Container(margin: EdgeInsets.all(_margin), 
          width: 200.0, height: 200.0 ,decoration:    
           BoxDecoration(boxShadow: [
            BoxShadow(
            color: Colors.black,
            blurRadius:1.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              1.0, // horizontal, move right 10
              1.0, // vertical, move down 10
            ),
          )],borderRadius: BorderRadius.circular(_cornerRadius))
          ,child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(_cornerRadius)) , child: Image.asset(Images.cherries,fit: BoxFit.cover,))),

          ///Water Section
          Card(margin: EdgeInsets.all(_margin),child: 
            Container(padding: EdgeInsets.all(_padding), child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[

           Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[

             Expanded(child:
              Container(margin: EdgeInsets.all(_margin) ,child:
              Text(StringLabels.water, style: Theme.of(context).textTheme.title,),),),

          
          Container(margin: EdgeInsets.all(_margin), 
          width: 40.0, height: 40.0 ,decoration:    
           BoxDecoration(boxShadow: [
            BoxShadow(
            color: Colors.black,
            blurRadius:1.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              1.0, // horizontal, move right 10
              1.0, // vertical, move down 10
            ),
          )],borderRadius: BorderRadius.circular(20.0))
          ,child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(_cornerRadius)) , child: Image.asset(Images.cherries,fit: BoxFit.cover,))),
            ]),

              Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[

             Expanded(child: 
             Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
              Container(margin: EdgeInsets.all(_margin) ,child: Text(StringLabels.profile, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.start,
              decoration: new InputDecoration.collapsed( 
              hintText: 'Username'                 ),
              onChanged:(text){} ,))]),),   

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.end,children: <Widget>[
              Container(margin: EdgeInsets.all(_margin) , child:Text(StringLabels.temparature, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.end,
                decoration: new InputDecoration.collapsed(
                hintText: 'Username'
                ), onChanged:(text){} ,))]),)

            ],)]),),),

          /// Ratios
          
            Card(margin: EdgeInsets.all(_margin),child: 
            Container(padding: EdgeInsets.all(_padding), child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[

              Container(margin: EdgeInsets.all(_margin) ,child:
              Text(StringLabels.ratios, style: Theme.of(context).textTheme.title,),),

              Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[

             Expanded(child: 
             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Container(margin: EdgeInsets.all(_margin) ,child: Text(StringLabels.brewingDose, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.center,
              decoration: new InputDecoration.collapsed( 
              hintText: StringLabels.brewingDose                 ),
              onChanged:(text){} ,))]),),   

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Container(margin: EdgeInsets.all(_margin) ,child:Text(StringLabels.yield, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.center,
                decoration: new InputDecoration.collapsed(
                hintText: StringLabels.yield
                ), onChanged:(text){} ,))]),),

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Container(margin: EdgeInsets.all(_margin) ,child:Text(StringLabels.brewWeight, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.center,
                decoration: new InputDecoration.collapsed(
                hintText: StringLabels.brewWeight
                ), onChanged:(text){} ,))]),)   

            ],)]),),),

            
          /// Grinder section
            Card(margin: EdgeInsets.all(_margin),child: 
            Container(padding: EdgeInsets.all(_padding), child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[

              Container(margin: EdgeInsets.all(_margin) ,child:
              Text(StringLabels.grinder , style: Theme.of(context).textTheme.title,),),

            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[

             Expanded(child: 
             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Container(margin: EdgeInsets.all(_margin) ,child: Text(StringLabels.profile, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.center,
              decoration: new InputDecoration.collapsed( 
              hintText: 'Username'                 ),
              onChanged:(text){} ,))]),),   

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Container(margin: EdgeInsets.all(_margin) ,child: Text(StringLabels.grindSetting, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.center,
                decoration: new InputDecoration.collapsed(
                hintText: 'setting'
                ), onChanged:(text){} ,))]),)

            ],)]),),),



          /// Equipment
          
           Card(margin: EdgeInsets.all(_margin),child: 
            Container(padding: EdgeInsets.all(_padding), child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[

              Container(margin: EdgeInsets.all(_margin) ,child:
              Text(StringLabels.brewingEquipment , style: Theme.of(context).textTheme.title,),),

            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[

             Expanded(child: 
             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Container(margin: EdgeInsets.all(_margin) ,child: Text(StringLabels.profile, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.center,
              decoration: new InputDecoration.collapsed( 
              hintText: 'Equipment'                 ),
              onChanged:(text){} ,))]),),   

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Container(margin: EdgeInsets.all(_margin) ,child: Text(StringLabels.grindSetting, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.center,
                decoration: new InputDecoration.collapsed(
                hintText: 'Preinfusion'
                ), onChanged:(text){} ,))]),)

            ],)]),),),



            ///Score Section
            Card(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[

            Container(margin: EdgeInsets.all(_margin) ,child:
              Text(StringLabels.score , style: Theme.of(context).textTheme.title,),),

            Column(children: <Widget>[

            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
             Container(margin: EdgeInsets.all(_margin) , child:Text(StringLabels.strength),),
              Slider(value: 0.1, onChanged: (value){},)]),

            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
               Container(margin: EdgeInsets.all(_margin) , child:Text(StringLabels.balance),),
              Slider(value: 0.1, onChanged: (value){},)]),

            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
               Container(margin: EdgeInsets.all(_margin) , child: Text(StringLabels.flavour),),
              Slider(value: 0.1, onChanged: (value){},)]),

            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
               Container(margin: EdgeInsets.all(_margin) , child: Text(StringLabels.body),),
              Slider(value: 0.1, onChanged: (value){},)]),

            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
               Container(margin: EdgeInsets.all(_margin) , child: Text(StringLabels.afterTaste),),
              Slider(value: 0.1, onChanged: (value){},)]), 

            

            ],)],),
            ),
        ],)
      ],
      ),    
    );}
}

class ScoreSlider extends StatefulWidget{ScoreSliderState createState() => new ScoreSliderState();}
class ScoreSliderState extends State<ScoreSlider>{

double _value = 0;
String _label;

@override
  Widget build(BuildContext context) {
    return Slider(
      value: _value,
      onChanged:(value){setState(() { _value = value; });} ,
      onChangeEnd:(value){}  ,
      onChangeStart:(value){} ,
      min: 0,
      max: 10,
      divisions: 10 ,
      label: _value.toString() ,
      activeColor: Theme.of(context).sliderTheme.inactiveTrackColor ,
      inactiveColor: Theme.of(context).sliderTheme.inactiveTrackColor,
      // semanticFormatterCallback: ,

    );
  }
}