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
       ProfileImage(),

      CoffeeCard(),
          
       UserDateInputCard(),


          ///Water Section
          ///
           ProfileInputCard(
            imageRefString: Images.drop,
            title: StringLabels.water,
            onAttributeTextChange:(text){},
            onProfileTextPressed: (text){},
            profileTextfieldText: '',
            attributeTextfieldText: '',
            attributeHintText: StringLabels.enterValue,
            attributeTitle: StringLabels.temparature
          ),
          
          /// Grinder

          ProfileInputCard(
            imageRefString: Images.grinder,
            title: StringLabels.grinder,
            onAttributeTextChange:(text){},
            onProfileTextPressed: (text){},
            profileTextfieldText: '',
            attributeTextfieldText: '',
            attributeHintText: StringLabels.enterValue,
            attributeTitle: StringLabels.grindSetting
          ),


          /// Equipment
          /// 
           ProfileInputCard(
            imageRefString: Images.aeropressSmaller512x512,
            title: StringLabels.brewingEquipment,
            onAttributeTextChange:(text){},
            onProfileTextPressed: (text){},
            profileTextfieldText: '',
            attributeTextfieldText: '',
            attributeHintText: StringLabels.enterValue,
            attributeTitle: StringLabels.preinfusion
          ),

          RatioCard(
            dosePressed:(dose){} ,
            yieldPressed:((yield){}) ,
            brewWeightPressed:(brewWeight){}),
          

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

            
/// End of score
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


////
/// Widgets
///
class ProfileInputCard extends StatelessWidget {
  
double _padding = 20.0;
double _margin = 10.0;
double _cornerRadius = 20.0; 
double _textFieldWidth = 150.0;

String imageRefString;
String title;
Function(String) onAttributeTextChange;
Function(String) onProfileTextPressed;
String profileTextfieldText;
String attributeTextfieldText;
String attributeHintText;
String profileHintText = StringLabels.chooseProfile;
String attributeTitle;
double _spacing = 15.0;


ProfileInputCard({
  this.imageRefString,
  this.title,
  this.onAttributeTextChange,
  this.onProfileTextPressed,
  this.profileTextfieldText,
  this.attributeTextfieldText,
  this.attributeHintText,
  this.attributeTitle,
});

  @override
  Widget build(BuildContext context) {
    return 
          
          Card(margin: EdgeInsets.all(_margin),child: 
            Container(padding: EdgeInsets.all(_padding), child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[

          Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[

          Container(margin: EdgeInsets.fromLTRB(0.0,0.0,0.0,_margin) ,child:
          Text(title, style: Theme.of(context).textTheme.title,),),

          Container(margin: EdgeInsets.fromLTRB(0.0,0.0,0.0,_margin), 
          width: 40.0, height: 40.0 , child: Image.asset(imageRefString,fit: BoxFit.cover,)),
              
          // Container(width: 10.0, height: 10.0,),

            ]),

              Container(width: _spacing, height: _spacing,),


              Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[

             Expanded(child: 
             Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[

              Container(child: Text(StringLabels.profile, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: _spacing, height: _spacing,),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.start,
              decoration: new InputDecoration.collapsed( 
              hintText: profileHintText),
              onChanged:onProfileTextPressed ,
              ))]),),   

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.end,children: <Widget>[
              Container(child:Text(attributeTitle, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: _spacing, height: _spacing,),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.end,
                decoration: new InputDecoration.collapsed(
                hintText: attributeHintText,
                
                ), onChanged:onAttributeTextChange ,))]),)

            ],)]),),);
  }
}

class UserDateInputCard extends StatelessWidget {
  
double _padding = 20.0;
double _margin = 10.0;
double _cornerRadius = 20.0; 
double _textFieldWidth = 150.0;
double _spacing = 15.0;

// String imageRefString;
// String title;
Function(String) onDateTextPressed;
Function(String) onCoffeePressed;
Function(String) onBaristaPressed;
// String profileTextfieldText;
// String attributeTextfieldText;
// String attributeHintText;
// String profileHintText = StringLabels.chooseProfile;
// String attributeTitle;

UserDateInputCard({
  this.onDateTextPressed,
  this.onCoffeePressed,
  this.onBaristaPressed,
  // this.profileTextfieldText,
  // this.attributeTextfieldText,
  // this.attributeHintText,
  // this.attributeTitle,
});

  @override
  Widget build(BuildContext context) {
    return 
          
          Container(margin: EdgeInsets.all(_margin),child: 
            Container(padding: EdgeInsets.all(_padding), child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[

            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[

             Expanded(child: 
             Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
              Container(child: Text(StringLabels.date, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: 15.0, height: _spacing,),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.start,
              decoration: new InputDecoration.collapsed( 
              hintText: StringLabels.enterInfo),
              onChanged:onDateTextPressed ,
              ))]),),   

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.end,children: <Widget>[
              Container(child:Text(StringLabels.barista, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: 10.0, height: _spacing,),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.end,
                decoration: new InputDecoration.collapsed(
                hintText: StringLabels.enterInfo,
                ), onChanged:onCoffeePressed ,))]),)           
            ],),
  
          ]),),);
  }
}


class ProfileImage extends StatelessWidget {
  double _padding = 20.0;
  double _margin = 10.0;
  double _textFieldWidth = 120.0;
  double _cornerRadius = 20.0; 
  Widget _backCancelButton;
  Widget _saveEditButton;

  @override
  Widget build(BuildContext context) {
    return 
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
          ,child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(_cornerRadius)) , child: Image.asset(Images.cherries,fit: BoxFit.cover,)));
  }
}

class CoffeeCard extends StatelessWidget {

  double _padding = 20.0;
  double _margin = 10.0;
  double _textFieldWidth = 120.0;
  double _cornerRadius = 20.0; 
  Widget _backCancelButton;
  Widget _saveEditButton;
  Function _onCoffeePressed;

  @override
  Widget build(BuildContext context){
    return
     Container(margin: EdgeInsets.all(_margin),child: Center( child:

         Container(margin: EdgeInsets.all(_margin) ,padding: EdgeInsets.all(_margin), child:
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Container(child:Text(StringLabels.coffee, style: Theme.of(context).textTheme.title,),),
              Container(width: 10.0, height: 10.0,),
              Container(width: _textFieldWidth , child: TextField(textAlign: TextAlign.center,
                decoration: new InputDecoration.collapsed(
                hintText: StringLabels.selectCoffee,
                ), onChanged: _onCoffeePressed ,))]),)   
     )
     );
  }
}

class RatioCard extends StatelessWidget {
  
double _padding = 20.0;
double _margin = 10.0;
double _cornerRadius = 20.0; 
double _textFieldWidth = 150.0;
double _spacing = 15.0;

Function(String) dosePressed;
Function(String) yieldPressed;
Function(String) brewWeightPressed;

RatioCard({
  this.dosePressed,
  this.yieldPressed,
  this.brewWeightPressed,
});

  @override
  Widget build(BuildContext context) {
    return 
          
          Container(margin: EdgeInsets.all(_margin), padding: EdgeInsets.all(_padding), child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[


          Container(margin: EdgeInsets.fromLTRB(0.0,0.0,0.0,_padding) ,child:
          Text(StringLabels.ratios, style: Theme.of(context).textTheme.title,),),

            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[

             Expanded(child: 
             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Container(child: Text(StringLabels.brewingDose, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: 15.0, height: _spacing,),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.center, keyboardType: TextInputType.number,
              decoration: new InputDecoration.collapsed( 
              hintText: StringLabels.enterInfo),
              onChanged: dosePressed ,
              ))]),),   

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center ,children: <Widget>[
              Container(child:Text(StringLabels.yield, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: 10.0, height: _spacing,),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.center, keyboardType: TextInputType.number,
                decoration: new InputDecoration.collapsed(
                hintText: StringLabels.enterInfo,
                ), onChanged: yieldPressed ,))]),),   

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center ,children: <Widget>[
              Container(child:Text(StringLabels.brewWeight, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: 10.0, height: _spacing,),
              Container(width: _textFieldWidth , child: TextField(textAlign: TextAlign.center, keyboardType: TextInputType.number,
                decoration: new InputDecoration.collapsed(
                hintText: StringLabels.enterInfo,
                ), onChanged: brewWeightPressed ,))]),)           
            ],),



            ],),
          );
  }
}
  