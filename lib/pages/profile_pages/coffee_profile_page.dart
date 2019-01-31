import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/pages/profile_pages/profile_page_model.dart';

/// Page
class CoffeeProfilePage extends StatefulWidget {

  _CoffeeProfilePageState createState() => new _CoffeeProfilePageState();
}

class _CoffeeProfilePageState extends State<CoffeeProfilePage> {  

  /// UI Build
  @override
  Widget build(BuildContext context) {
    return 
    
     ScopedModelDescendant(builder: (BuildContext context,_, ProfilePageModel model) =>

     StreamBuilder<Profile>(
            stream: model.profileStream,
            builder: (BuildContext context, AsyncSnapshot<Profile> snapshot){
              if (!snapshot.hasData){ return Center(child: CircularProgressIndicator(),);}

              return
              
          Column(
            children: <Widget>[

              Card(child:
              Container(margin: EdgeInsets.all(10), height: 100.0, child:
              Column(mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
              TextFieldItemWithInitalValue
              (snapshot.data.getItem( DatabaseIds.coffeeId), 300)]))),
              
              RoastingDetailsCard(),

              ///Origin details
              OriginDetailsCard(),

              /// Green details
              GreenDetailsCard(),
                
              ],
          );
  }
     )
     );
}
}




//Widgets

/// Origin details
class OriginDetailsCard extends StatelessWidget {
  final double _padding = 5.0;
  final double _margin = 5.0;
  final double _textFieldWidth = 150.0;
 
 @override
  Widget build(BuildContext context) {

    return 
    
      
    ScopedModelDescendant(builder: (BuildContext context,_, ProfilePageModel model) =>

    StreamBuilder<Profile>(
          stream: model.profileStream,
          builder: (BuildContext context, AsyncSnapshot<Profile> snapshot){
            return
    Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        Text(StringLabels.originDetails, style: Theme.of(context).textTheme.title,),
        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Region
          TextFieldItemWithInitalValue(snapshot.data.getItem(DatabaseIds.region),_textFieldWidth),
          
          ///Farm
          TextFieldItemWithInitalValue(snapshot.data.getItem(DatabaseIds.farm),_textFieldWidth),
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
        ///Producer
          TextFieldItemWithInitalValue(snapshot.data.getItem(DatabaseIds.producer),_textFieldWidth),
        ///Lot
          TextFieldItemWithInitalValue(snapshot.data.getItem(DatabaseIds.lot),_textFieldWidth),
        ],),

        ///Row 3
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Alititude
          TextFieldItemWithInitalValue(snapshot.data.getItem(DatabaseIds.altitude),_textFieldWidth),
          ///Country
          PickerTextField(snapshot.data.getItem(DatabaseIds.country), _textFieldWidth,),
        ],)
    ],),)
    );
          }
    )
    );
  }
}


/// Roasting details
class RoastingDetailsCard extends StatefulWidget {
 
  RoastingDetailsCardState createState() => new RoastingDetailsCardState();
}

class RoastingDetailsCardState extends State<RoastingDetailsCard> {
  final double _margin = 5.0;
  final double _textFieldWidth = 150.0;

 @override
  Widget build(BuildContext context) {

    return
    
    ScopedModelDescendant(builder: (BuildContext context,_, ProfilePageModel model) =>

    StreamBuilder<Profile>(
          stream: model.profileStream,
          builder: (BuildContext context, AsyncSnapshot<Profile> snapshot){
            
    return Card(child:
    
     Container(padding: EdgeInsets.all( _margin), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[

        /// Title
        Container(padding: EdgeInsets.all( _margin), margin: EdgeInsets.all( _margin), child: 
        Text(StringLabels.roastedCoffeeDetails, style: Theme.of(context).textTheme.title,),),

        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
      
        DateInputCard(
          StringLabels.date,
          snapshot.data.getItemValue(DatabaseIds.roastDate),
          (dateTime) {if ( dateTime != null ){ model.setProfileItemValue( DatabaseIds.roastDate , dateTime );}},
          ),

        ///Roast profile
          PickerTextField
          (snapshot.data.getItem(DatabaseIds.roastProfile), _textFieldWidth),                  
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[
          ///Roastery Name
          TextFieldItemWithInitalValue
          (snapshot.data.getItem(DatabaseIds.roasteryName), _textFieldWidth) ,    
          
          /// Roaster name
          TextFieldItemWithInitalValue
          (snapshot.data.getItem(DatabaseIds.roasterName), _textFieldWidth) ,    
                                 
        ],)
    ],))
    );
  })
    );
}
}           
        
class ProfileInputCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 150.0;

  final String imageRefString;
  final String title;
  final Function(String) onAttributeTextChange;
  final Function onProfileTextPressed;
  final String profileTextfieldText;
  final String attributeTextfieldText;
  final String attributeHintText;
  final String profileHintText = StringLabels.chooseProfile;
  final String attributeTitle;
  final double _spacing = 5.0;
  final TextInputType keyboardType;

  ProfileInputCard(
      {this.imageRefString,
      this.title,
      this.onAttributeTextChange,
      this.onProfileTextPressed,
      this.attributeTextfieldText,
      this.attributeHintText,
      this.attributeTitle,
      this.profileTextfieldText,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(_margin),
        child: Container(
            padding: EdgeInsets.all(_padding),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, _margin),
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: onProfileTextPressed,
                          child: Text(
                            StringLabels.selectProfile,
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, _margin),
                            width: 40.0,
                            height: 40.0,
                            child: Image.asset(
                              imageRefString,
                              fit: BoxFit.cover,
                            )),

                        Container(
                          width: _spacing,
                          height: _spacing,
                        ),

                        Container(
                            width: _textFieldWidth,
                            child: TextField(
                              textAlign: TextAlign.end,
                              keyboardType: keyboardType,
                              decoration: new InputDecoration(
                                labelText: attributeTitle,
                                hintText: attributeHintText,
                              ),
                              onChanged: onAttributeTextChange,
                            ))
                      ])
                ])));
  }
}

///Green details
class GreenDetailsCard extends StatelessWidget {
  final double _padding = 5.0;
  final double _margin = 5.0;
  final double _textFieldWidth = 150.0;

 @override
  Widget build(BuildContext context) {
    return 
    
    ScopedModelDescendant(builder: (BuildContext context,_, ProfilePageModel model) =>

    StreamBuilder<Profile>(
          stream: model.profileStream,
          builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) =>

    Card(child: Container(padding: EdgeInsets.all(_padding), margin: EdgeInsets.all( _margin), child: Column(children: <Widget>[


        /// Name
        Text(StringLabels.greenCoffeeDetails, style: Theme.of(context).textTheme.title,),

        ///Row 1
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[

          ///BeanType
          PickerTextField(snapshot.data.getItem(DatabaseIds.beanType), _textFieldWidth),
        
          ///BeanSize
          PickerTextField(snapshot.data.getItem(DatabaseIds.beanSize), _textFieldWidth),
        ],),

        ///Row 2
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[

          ///Processing Methord
          PickerTextField(snapshot.data.getItem(DatabaseIds.processingMethod), _textFieldWidth),

          ///Density
          TextFieldItemWithInitalValue(snapshot.data.getItem(DatabaseIds.density), _textFieldWidth,)                
        ],),

        ///Row 3
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[

          ///Water activity
          TextFieldItemWithInitalValue(snapshot.data.getItem(DatabaseIds.aW),_textFieldWidth),

          ///moisture Content
          TextFieldItemWithInitalValue(snapshot.data.getItem(DatabaseIds.moisture),_textFieldWidth)                  
        ],),

        ///Row 4
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: <Widget>[

          ///Harvest
          TextFieldItemWithInitalValue(snapshot.data.getItem(DatabaseIds.harvest), _textFieldWidth),

        /// Harvest to implement TODO
        // DateTimeInputCard(
        //   StringLabels.harvest,
        //   DateTime.now(),
        //   (dateTime)
        //   {},
        //   _isEditing
        // ),
                     
        ],),

    ],))
    )

    )
  );
  }
}
