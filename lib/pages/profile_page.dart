import 'package:flutter/material.dart' show AppBar, BuildContext, FontWeight, Icon, Icons, Navigator, RawMaterialButton, Scaffold, State, StatefulWidget, Text, TextStyle, required;
import  '../data/profile.dart';
import '../data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/images.dart';
import '../widgets/custom_widgets.dart';
import '../data/functions.dart';
import '../database_functions.dart';

class ProfilePage extends StatefulWidget{

  @required final bool isCopying;
  @required final bool isEditing; 
  @required final bool isNew;
  @required final ProfileType type; 
  @required final String referance;
  String appBarTitle;
  Profile _profile;


  ProfilePage({this.isCopying, this.isEditing, this.isNew, this.type, this.referance}){
    

    if (isNew || isCopying){ this.appBarTitle = StringLabels.newe + ' ' + Functions.getProfileTypeString(type) + ' ' + StringLabels.profile; }
   
    // profile.image = Image.asset(Images.coffeeBeans);
    _profile = Functions.createBlankProfile(type);
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
  Profile _profile;
  @required  bool _isCopying; 
  @required  bool _isEditing; 
  @required  bool _isNew; 



  void initState() { 
  
  _isCopying =  widget.isCopying;
  _isEditing =  widget.isEditing;
  _isNew = widget.isNew;

  /// Set back button depending on state
  // _backCancelButton =  _isEditing ? 
  // RawMaterialButton(child: Icon(Icons.arrow_back), onPressed:(){ Navigator.pop(context); } ,):
  // RawMaterialButton(child: Text(StringLabels.cancel), onPressed:(){ setState((){_isEditing = false; print(_isEditing.toString());});});  
 
  /// Set save button depending on state
  // _saveEditButton =  widget.isEditing ? 
  // RawMaterialButton(child: Icon(Icons.edit),onPressed:(){ _isEditing = true; } ,):
  // RawMaterialButton(child: Text(StringLabels.save),onPressed:(){ print('big job');} ,);  

  _profile = widget._profile;

  super.initState();
  }
 

///
/// UI Build
///
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(centerTitle: true, title: Text(widget.appBarTitle, style: TextStyle( fontWeight: FontWeight.w700, fontSize: 15.0),), automaticallyImplyLeading: false,
      leading:  _isEditing ? 
        RawMaterialButton(child: Icon(Icons.cancel), onPressed:(){ setState((){_isEditing = false; print(_isEditing.toString());});}):
        RawMaterialButton(child: Icon(Icons.arrow_back), onPressed:(){ Navigator.pop(context); } ,),
      actions: <Widget>[  _isEditing ? 
        RawMaterialButton(child: Icon(Icons.save_alt),onPressed:(){ print('big job');} ,):
        RawMaterialButton(child: Icon(Icons.edit),onPressed:(){ setState((){_isEditing = true; print(_isEditing);}); }),  
           ],),

      body: ListView(children: <Widget>[

      Column(children: <Widget>[  

      /// Profile Image
      ProfileImage(Image.asset(Images.coffeeBeans)),

      FlatButton(onPressed: (){}, child: Text(StringLabels.changeImage),),

      CoffeeCard(),
          
       UserDateInputCard(),

          ///Water Section
           ProfileInputCard(
            imageRefString: Images.drop,
            title: StringLabels.water,
            onAttributeTextChange:(text){_profile = Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.temparature, value: text );},
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
            onAttributeTextChange:(text){_profile = Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.grindSetting, value: text );},
            onProfileTextPressed: (text){},
            profileTextfieldText: '',
            attributeTextfieldText: '',
            attributeHintText: StringLabels.enterValue,
            attributeTitle: StringLabels.setting
          ),


          /// Equipment
          /// 
           ProfileInputCard(
            imageRefString: Images.aeropressSmaller512x512,
            title: StringLabels.brewingEquipment,
            onAttributeTextChange:(text){_profile = Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.preinfusion, value: text );},
            onProfileTextPressed: (text){},
            profileTextfieldText: '',
            attributeTextfieldText: '',
            attributeHintText: StringLabels.enterValue,
            attributeTitle: StringLabels.preinfusion
          ),

          RatioCard(
            doseChanged:(dose){_profile = Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.brewingDose, value: dose );} ,
            yieldChanged:((yield){_profile = Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.yield, value: yield );}) ,
            brewWeightChanged:(brewWeight){_profile = Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.brewWeight, value: brewWeight );}),

          TwoTextfieldCard( titleLeft: StringLabels.time, titleRight: StringLabels.tds,
            onLeftTextChanged: (text){ Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.time, value: text );},  
            onRightTextChanged: (text){ Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.tds, value: text );},),
            
          
            ///Score Section
          Card(child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[

            Container(margin: EdgeInsets.all(_margin) ,child:
              Text(StringLabels.score , style: Theme.of(context).textTheme.title,),),

            Column(children: <Widget>[

            ScoreSlider(StringLabels.strength, 0.0 , (value){ Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.strength, value: value );}),

            ScoreSlider(StringLabels.balance, 0.0 , (value){ Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.balance, value: value );}),

            ScoreSlider(StringLabels.flavour, 0.0 , (value){ Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.flavour, value: value );}),

            ScoreSlider(StringLabels.body, 0.0 , (value){ Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.body, value: value );}),

            ScoreSlider(StringLabels.afterTaste, 0.0 , (value){ Functions.setProfileItemValue(profile: _profile, keyDatabaseId: DatabaseIds.afterTaste, value: value );})
            
/// End of score
            ],)],),
            ),
        ],)
      ],
      ),    
    );}
}

/// End of Page
/// 


/// Widgets


class ScoreSlider extends StatefulWidget{
  
final double _value ;
final String _label;
final Function(double) _sliderValue;

  ScoreSlider(this._label, this._value, this._sliderValue);

  ScoreSliderState createState() => new ScoreSliderState();}

class ScoreSliderState extends State<ScoreSlider>{

double _value;
String _label;
double _margin = 10.0;

@override
  void initState() { 
    _value = widget._value;
    _label = widget._label;
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    return 
    
     Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
               Container(margin: EdgeInsets.all(_margin) , child: Text(widget._label),),
    Slider(
      value: _value,
      onChanged:(value){setState(() { _value = value;  });  widget._sliderValue;} ,
      onChangeEnd:(value){}  ,
      onChangeStart:(value){} ,
      min: 0,
      max: 10,
      divisions: 10 ,
      label: _value.toInt().toString() ,
      activeColor: Theme.of(context).sliderTheme.inactiveTrackColor ,
      inactiveColor: Theme.of(context).sliderTheme.inactiveTrackColor,
      // semanticFormatterCallback: ,

    )
     ]);
  }
}


////
/// Widgets
///
class ProfileInputCard extends StatelessWidget {
  
final double _padding = 20.0;
final double _margin = 10.0;
final double _cornerRadius = 20.0; 
final double _textFieldWidth = 150.0;

final String imageRefString;
final String title;
final Function(String) onAttributeTextChange;
final Function(String) onProfileTextPressed;
final String profileTextfieldText;
final String attributeTextfieldText;
final String attributeHintText;
final String profileHintText = StringLabels.chooseProfile;
final String attributeTitle;
final double _spacing = 5.0;


ProfileInputCard({
  this.imageRefString,
  this.title,
  this.onAttributeTextChange,
  this.onProfileTextPressed,
  this.attributeTextfieldText,
  this.attributeHintText,
  this.attributeTitle,
  this.profileTextfieldText
});

  @override
  Widget build(BuildContext context) {
    return 
          Card(margin: EdgeInsets.all(_margin),child: 
          Container(padding: EdgeInsets.all(_padding), child: 
          Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[

          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[

          Container(margin: EdgeInsets.fromLTRB(0.0,0.0,0.0,_margin) ,child:
          Text(title, style: Theme.of(context).textTheme.title,),),

          RawMaterialButton(onPressed: (){}, child: 
               Text(StringLabels.selectProfile, style: TextStyle(fontSize: 20),),)

          ]),

          Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[

          Container(margin: EdgeInsets.fromLTRB(0.0,0.0,0.0,_margin), 
          width: 40.0, height: 40.0 , child: Image.asset(imageRefString,fit: BoxFit.cover,)),

          Container(width: _spacing, height: _spacing,),
  
          Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
            Container(child: Text(attributeTitle, style: Theme.of(context).textTheme.subtitle,),),
            Container(width: _spacing, height: _spacing,),
            Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.end,
              decoration: new InputDecoration.collapsed(
              hintText: attributeHintText,),
            onChanged:onAttributeTextChange ,))])

            ])])));
  }
}

/// User profile

class UserDateInputCard extends StatelessWidget {
  
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0; 
  final double _textFieldWidth = 150.0;
  final double _spacing = 15.0;

  final Function(String) onDateTextPressed;
  final Function(String) onCoffeePressed;
  final Function(String) onBaristaPressed;

  UserDateInputCard({
    this.onDateTextPressed,
    this.onCoffeePressed,
    this.onBaristaPressed,
  });

  @override
  Widget build(BuildContext context) {
    return     
          Container(margin: EdgeInsets.all(_margin),child: 
            Container(padding: EdgeInsets.all(_padding), child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[

            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[

             Expanded(child: 
             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Container(child: Text(StringLabels.date, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: 15.0, height: _spacing,),
              RawMaterialButton(onPressed: (){},child: Text(StringLabels.date, style: TextStyle(fontSize: 20)))
              
              ]),),   

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
              Container(child:Text(StringLabels.barista, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: 10.0, height: _spacing,),
              RawMaterialButton(onPressed: (){},child: Text(StringLabels.barista ,style: TextStyle(fontSize: 20)))
              ]),)           
            
            
            ],),
          ]),),);
  }
}


class ProfileImage extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 120.0;
  final double _cornerRadius = 20.0;
  final Image _image; 

  ProfileImage(this._image);

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

  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 120.0;
  final double _cornerRadius = 20.0; 

  @override
  Widget build(BuildContext context){
    return
        Container(margin: EdgeInsets.all(_margin) ,padding: EdgeInsets.all(_margin), child:
          Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
            Container(child:Text(StringLabels.coffee, style: Theme.of(context).textTheme.title,),),
            Container(width: 10.0, height: 10.0),
            RawMaterialButton(onPressed: (){},child: Text(StringLabels.selectCoffee),),
          ]),) ;  
  }
}

class RatioCard extends StatelessWidget {
  
final double _padding = 20.0;
final double _margin = 10.0;
final double _cornerRadius = 20.0; 
final double _textFieldWidth = 150.0;
final double _spacing = 15.0;
final Function(String) doseChanged;
final Function(String) yieldChanged;
final Function(String) brewWeightChanged;

RatioCard({
  this.doseChanged,
  this.yieldChanged,
  this.brewWeightChanged,
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
              onChanged: doseChanged ,
              ))]),),   

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center ,children: <Widget>[
              Container(child:Text(StringLabels.yield, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: 10.0, height: _spacing,),
              Container(width: _textFieldWidth , child:TextField(textAlign: TextAlign.center, keyboardType: TextInputType.number,
                decoration: new InputDecoration.collapsed(
                hintText: StringLabels.enterInfo,
                ), onChanged: yieldChanged ,))]),),   

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center ,children: <Widget>[
              Container(child:Text(StringLabels.brewWeight, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: 10.0, height: _spacing,),
              Container(width: _textFieldWidth , child: TextField(textAlign: TextAlign.center, keyboardType: TextInputType.number,
                decoration: new InputDecoration.collapsed(
                hintText: StringLabels.enterInfo,
                ), onChanged: brewWeightChanged ,))]),)           
            ],),

            ],),
          );
  }
}

class TwoTextfieldCard extends StatelessWidget {
  
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0; 
  final double _textFieldWidth = 150.0;
  final double _spacing = 15.0;
  final String titleLeft;
  final String titleRight;

  final Function(String) onLeftTextChanged;
  final Function(String) onRightTextChanged;

  TwoTextfieldCard({
    @required this.onLeftTextChanged,
    @required this.onRightTextChanged,
    @required this.titleLeft,
    @required this.titleRight
  });

  @override
  Widget build(BuildContext context) {
    return     
          Container(margin: EdgeInsets.all(_margin),child: 
            Container(padding: EdgeInsets.all(_padding), child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[

            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[

             Expanded(child: 
             Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Container(child: Text(titleLeft, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: 15.0, height: _spacing,),
              Container(width: _textFieldWidth , child: TextField(textAlign: TextAlign.center, keyboardType: TextInputType.number,
                decoration: new InputDecoration.collapsed(
                hintText: StringLabels.enterInfo,
                ), onChanged: onLeftTextChanged ,))
              
              ]),),   

            Expanded(child: 
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
              Container(child:Text(titleRight, style: Theme.of(context).textTheme.subtitle,),),
              Container(width: 10.0, height: _spacing,),
              Container(width: _textFieldWidth , child: TextField(textAlign: TextAlign.center, keyboardType: TextInputType.number,
                decoration: new InputDecoration.collapsed(
                hintText: StringLabels.enterInfo,
                ), onChanged: onRightTextChanged ,))
              ]),)           
            
            ],),
          ]),),);
  }
}
  