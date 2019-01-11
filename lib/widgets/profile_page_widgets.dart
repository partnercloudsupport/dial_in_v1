import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/item.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:flutter/services.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';

class ScoreSlider extends StatefulWidget {
  final double _value;
  final String _label;
  final Function(double) _sliderValue;
  final bool _isEditing;

  ScoreSlider(this._label, this._value, this._sliderValue, this._isEditing);

  ScoreSliderState createState() => new ScoreSliderState();
}
class ScoreSliderState extends State<ScoreSlider> {
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
    Container(margin: EdgeInsets.all(_margin), padding:EdgeInsets.all(_margin) , child: 
    Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(_margin),
            padding: EdgeInsets.all(_margin),
            child: Text(widget._label),
          ),
          Slider(
          
            value: _value,
            onChanged: widget._isEditing? (value){
              setState(() {
                _value = value;
              });}: null,
            onChangeEnd:  (value) {
              
              widget._sliderValue(value);
            },
            min: 0,
            max: 10,
            divisions: 10,
            label: _value.toInt().toString(),
            activeColor: Theme.of(context).sliderTheme.inactiveTrackColor,
            inactiveColor: Theme.of(context).sliderTheme.inactiveTrackColor,
            
          )
        ]
        )
    );
  }
}

/// Widgets

class ProfileInputCardWithAttribute extends StatefulWidget {

  final double _padding = 5.0;
  final double _margin = 5.0;
  final double _textFieldWidth = 150.0;
  
  final Function(String) onAttributeTextChange;
  final Function onProfileTextPressed;
  final String attributeTextfieldText;
  final String attributeHintText;
  final String profileHintText = StringLabels.chooseProfile;
  final String attributeTitle;
  final TextInputType keyboardType;
  final Profile profile;
  final bool _isEditing;
  

  ProfileInputCardWithAttribute(this._isEditing,
      {
      this.profile,
      this.onAttributeTextChange,
      this.onProfileTextPressed,
      this.attributeTextfieldText,
      this.attributeHintText,
      this.attributeTitle,
      this.keyboardType,
      }
      );

      _ProfileInputCardWithAttributeState createState() => new _ProfileInputCardWithAttributeState();
}
class _ProfileInputCardWithAttributeState extends State<ProfileInputCardWithAttribute> {

      TextEditingController _attributeController;
      TextEditingController _profileTextController;
      FocusNode _textFocus;

      @override
       void initState() {
            _attributeController = new TextEditingController(text: widget.attributeTextfieldText);
            _attributeController.addListener(sendAttributeValue);
            _profileTextController = new TextEditingController();
            _textFocus = new FocusNode();
            _textFocus.addListener(handleProfileTextfieldFocus);
            super.initState();
      }

      @override
      void dispose() {
        // Clean up the controller when the Widget is removed from the Widget tree
        _attributeController.dispose();
        _profileTextController.dispose();
        super.dispose();
      }

      void sendAttributeValue(){
        widget.onAttributeTextChange(_attributeController.text);
      }

      void handleProfileTextfieldFocus(){
        if (_textFocus.hasFocus){
        widget.onProfileTextPressed();
        _textFocus.unfocus();  
        }
      }

       @override
          void didUpdateWidget(Widget oldWidget) {
            _profileTextController.text =  widget.profile.getProfileTitleValue();
           super.didUpdateWidget(oldWidget);
      }


  @override
  Widget build(BuildContext context) {
    _profileTextController.text =  widget.profile.getProfileTitleValue();
    return Card(
        margin: EdgeInsets.all(widget._margin),
          child: Container(
            padding: EdgeInsets.all(widget._padding),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  /// Left profile selection
             
                       CircularPicture(widget.profile.image, 40.0),

                        /// Spacer
                        Container(width: 10.0,),

                      Expanded(flex:1 ,child:
                        Container(
                          margin: EdgeInsets.all(5.0),child: 
                          TextFormField(
                            enabled: widget._isEditing,
                            textAlign: TextAlign.start,
                            keyboardType: widget.keyboardType,
                            decoration: new InputDecoration(
                              labelText: widget.profile.databaseId,
                              hintText: StringLabels.selectProfile,),
                            focusNode: _textFocus,
                            controller: _profileTextController,)
                      ),),

                      /// Spacer
                        Container(width: 20.0,),

                        Expanded(flex:1, child:
                            Container(margin: EdgeInsets.all(10.0), child:
                             TextFormField(
                              enabled: widget._isEditing,
                              textAlign: TextAlign.start,
                              keyboardType: widget.keyboardType,
                              decoration: new InputDecoration(
                                labelText: widget.attributeTitle,
                                hintText: widget.attributeHintText,),
                                controller: _attributeController,
                              )
                            )
                        )
                      ]
                )
              )
            );
    }
}


///Double profile card
class DoubleProfileInputCard extends StatefulWidget {

  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;

  final String leftImageRefString;
  final String leftTitle;
  final String leftTextfieldText;
  final String leftHintText;
  final Function onLeftProfileTextPressed;
  final String rightImageRefString;
  final String rightTitle;
  final String rightTextfieldText;
  final String rightHintText;
  final Function onRightProfileTextPressed;
 

  DoubleProfileInputCard({   
    @required this.leftImageRefString,
    @required this.leftTitle,
    @required this.leftTextfieldText,
    @required this.leftHintText,
    @required this.onLeftProfileTextPressed,

    @required this.rightImageRefString,
    @required this.rightTitle,
    @required this.rightTextfieldText,
    @required this.rightHintText,
    @required this.onRightProfileTextPressed,
    });

      _DoubleProfileInputCardState createState() => new _DoubleProfileInputCardState();
}
class _DoubleProfileInputCardState extends State<DoubleProfileInputCard> {

      TextEditingController _leftController;
       FocusNode _leftFocus;
     
      TextEditingController _rightController;
       FocusNode _rightFocus;

    
      @override
       void initState() {

            _leftFocus = new FocusNode();
            _leftFocus.addListener(handleLeftProfileTextfieldFocus);
            _rightFocus = new FocusNode();
            _rightFocus.addListener(handleRightProfileTextfieldFocus);
            super.initState();
      }

      @override
          void didUpdateWidget(Widget oldWidget) {
            _leftController = new TextEditingController(text: widget.leftTextfieldText);
            _rightController = new TextEditingController(text: widget.rightTextfieldText);
           super.didUpdateWidget(oldWidget);
          }

      @override
      void dispose() {
        // Clean up the controller when the Widget is removed from the Widget tree
        _leftController.dispose();
        _rightController.dispose();
        super.dispose();
      }


      void handleLeftProfileTextfieldFocus(){
        if (_leftFocus.hasFocus){
        widget.onLeftProfileTextPressed();
        _leftFocus.unfocus();  
        }
      }

      void handleRightProfileTextfieldFocus(){
        if (_rightFocus.hasFocus){
        widget.onRightProfileTextPressed();
        _rightFocus.unfocus();  
        }
      }


  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(widget._margin),
          child: Container(
            padding: EdgeInsets.all(widget._padding),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  /// Left profile selection
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Container(
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, widget._margin),
                            width: 40.0,
                            height: 40.0,
                            child: Image.asset(
                              widget.leftImageRefString,
                              fit: BoxFit.cover,
                            )),

                        Container(
                          width: widget._textFieldWidth,
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, widget._margin),
                          child: TextFormField(
                              textAlign: TextAlign.end,
                              decoration: new InputDecoration(
                                labelText: widget.leftTitle,
                                hintText: widget.leftHintText,
                              ),
                              focusNode: _leftFocus,
                              controller: _leftController,
                              )
                        ),
                 
                      ]),

                  /// Right
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Container(
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, widget._margin),
                            width: 40.0,
                            height: 40.0,
                            child: Image.asset(
                              widget.rightImageRefString,
                              fit: BoxFit.cover,
                            )),

                        Container(
                          width: widget._textFieldWidth,
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, widget._margin),
                          child: TextFormField(
                              textAlign: TextAlign.end,
                              decoration: new InputDecoration(
                                labelText: widget.rightTitle,
                                hintText: widget.rightHintText,
                              ),
                              focusNode: _rightFocus,
                              controller: _rightController,),
                        ),
                      ]),
                ])));
  }
}

///Profile details card
class ProfileInputWithDetailsCard extends StatefulWidget {
  final double _padding = 5.0;
  final double _margin = 5.0;
  final double _cornerRadius = 20.0;
  final double _textFieldWidth = 150.0;
  final Profile _profile;
  final String _detailTitle;
  final String _detailValue;
  final Function _onProfileTextPressed;
  final bool _isEditing;

  ProfileInputWithDetailsCard
  (this._isEditing, this._profile, this._detailTitle, this._detailValue, this._onProfileTextPressed,);

  ProfileInputWithDetailsCardState createState() => ProfileInputWithDetailsCardState();
}
class ProfileInputWithDetailsCardState extends State<ProfileInputWithDetailsCard> {

  TextEditingController _controller;
  TextEditingController _detailController;

  FocusNode _focus;

      @override
       void initState() {
            _focus = new FocusNode();
            _focus.addListener(handleLeftProfileTextfieldFocus);
            _controller = new TextEditingController();
            _detailController = new TextEditingController();
            super.initState();
      }

      @override
        void didUpdateWidget(Widget oldWidget) {
          _controller.text = widget._profile.getProfileTitleValue();
          _detailController.text =  widget._detailValue;
         super.didUpdateWidget(oldWidget);
        }

      @override
      void dispose() {
        // Clean up the controller when the Widget is removed from the Widget tree
        _controller.dispose();
        _detailController.dispose();
        super.dispose();
      }

      void handleLeftProfileTextfieldFocus(){
        if (_focus.hasFocus){
        widget._onProfileTextPressed();
        setState(() {
                  _focus.unfocus(); 
                });
        }
      }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Card(
        margin: EdgeInsets.all(widget._margin),
          child: Container(
            padding: EdgeInsets.fromLTRB(5.0,widget._padding,widget._padding,widget._padding),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  CircularPicture(widget._profile.image, 40.0),
                  
                  Container(width: 10.0,),


                  /// Profile
                  Expanded(child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, widget._margin, 0.0),
                          child: TextFormField(
                              enabled: widget._isEditing,
                              textAlign: TextAlign.start,
                              decoration: new InputDecoration(
                                labelText: widget._profile.databaseId,
                              ),
                              focusNode: _focus,
                              controller: _controller,
                          ))),

                  /// Spacer        
                  Container(width: 10.0,),
                  
                  /// Attribute Value
                  Expanded(child: 
                  Container(margin: EdgeInsets.fromLTRB(0.0, 0.0, widget._margin, 0.0), child: 
                  ScalableWidget(
                  TextfieldWithFixedValue(widget._detailTitle, _detailController.text)))),

                ]
            )
          )
       )
    );
  }
}

/// TextField With pickerview


//Single profile card
class ProfileInputCard extends StatefulWidget {
  final double _padding = 5.0;
  final double _margin = 5.0;
  final Profile _profile;
  final Function _onProfileTextPressed;
  final bool _isEditing;


  ProfileInputCard(this._isEditing ,this._profile, this._onProfileTextPressed);

  _ProfileInputCardState createState() => _ProfileInputCardState();
}
class _ProfileInputCardState extends State<ProfileInputCard> {

  TextEditingController _controller;
  FocusNode _focus;

      @override
       void initState() {
            _focus = new FocusNode();
            _focus.addListener(handleLeftProfileTextfieldFocus);
            _controller = new TextEditingController();
            super.initState();
      }

      @override
          void didUpdateWidget(Widget oldWidget) {
            _controller.text =  widget._profile.getProfileTitleValue();
           super.didUpdateWidget(oldWidget);
          }

      @override
      void dispose() {
        // Clean up the controller when the Widget is removed from the Widget tree
        _controller.dispose();
        super.dispose();
      }

      void handleLeftProfileTextfieldFocus(){
        if (_focus.hasFocus){
          widget._onProfileTextPressed();
          _focus.unfocus();  
        }
      }

  @override
  Widget build(BuildContext context) {
    _controller.text =  widget._profile.getProfileTitleValue();
    return Container(
       child: Card(
        margin: EdgeInsets.all(widget._margin),
          child: Container(
            padding: EdgeInsets.all(widget._padding),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  CircularPicture(widget._profile.image, 40.0),

                  /// Spacer
                  Container(width: 10.0,),

                  Expanded(child:Container(
                    margin: EdgeInsets.all(widget._margin,),
                    child: TextFormField(
                        enabled: widget._isEditing,
                        textAlign: TextAlign.start,
                        decoration: new InputDecoration(
                          labelText: widget._profile.databaseId,
                        ),
                        focusNode: _focus,
                        controller: _controller,
                    ))),
                ]
            )
          )
       )
    );
  }
}

/// Profile image
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
        Container(
            margin: EdgeInsets.all(_margin),
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 1.0, // has the effect of softening the shadow
                spreadRadius: 1.0, // has the effect of extending the shadow
                offset: Offset(
                  1.0, // horizontal, move right 10
                  1.0, // vertical, move down 10
                ),
              )
            ], borderRadius: BorderRadius.circular(_cornerRadius)),
            child: Card(child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(_cornerRadius)),
                child: _image,
                ),) );
  }
}

/// Coffee Card
class CoffeeCard extends StatelessWidget {
  final double _padding = 20.0;
  final double _margin = 10.0;
  final double _textFieldWidth = 120.0;
  final double _cornerRadius = 20.0;
  final Function _openOptions;
  final String coffee;

  CoffeeCard(this._openOptions, this.coffee);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(_margin),
      padding: EdgeInsets.all(_margin),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(width: 10.0, height: 10.0),
            RawMaterialButton(
              onPressed: _openOptions,
              child: Text(StringLabels.selectCoffee),
            ),
            Container(
              child: Text(
                coffee,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ]),
    );
  }
}

/// Ratio Card
class RatioCard extends StatefulWidget {
  final double _margin = 5.0;
  final double _textFieldWidth = 80.0;
  final bool _isEditing;
  
  final Profile _profile;

  final Function(String) _doseChanged;
  final Function(String) _yieldChanged;
  final Function(String) _brewWeightChanged;

  RatioCard(
    this._profile,
    this._doseChanged,
    this._yieldChanged,
    this._brewWeightChanged,
    this._isEditing,
  );
  _RatioCardState createState() => _RatioCardState();
}
class _RatioCardState extends State<RatioCard> {

  BrewRatioType _brewRatioType = BrewRatioType.doseYield;
  RegExp _filter = RegExp('\.\s');
  BlacklistingTextInputFormatter _spaceBlacklistingTextInputFormatter = BlacklistingTextInputFormatter(RegExp(' '),replacementString: '');
  BlacklistingTextInputFormatter _commaBlacklistingTextInputFormatter = BlacklistingTextInputFormatter(RegExp(','),replacementString: '.');
  WhitelistingTextInputFormatter _whitelistingTextInputFormatter = WhitelistingTextInputFormatter(RegExp('[0-9,.]'));
  List<TextInputFormatter> _inpuFormatters = List<TextInputFormatter>();

  @override
    void initState() {
      _inpuFormatters = [_commaBlacklistingTextInputFormatter,_spaceBlacklistingTextInputFormatter,_whitelistingTextInputFormatter];
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return 
    
    ScopedModelDescendant<RatioModel>
            ( rebuildOnChange: false, builder: (context, _ ,model) =>

    Card(child:Container(
      margin: EdgeInsets.all(widget._margin),
      padding: EdgeInsets.all(widget._margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
              Container(width: 130.0, child:
              RaisedButton( 
                shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                child: Text('Calc Yield',softWrap: true, textAlign: TextAlign.center,),
                onPressed: () => widget._yieldChanged(model.estimateBrewRatio(BrewRatioType.doseYield,)))),

              Container(width: 130.0, child:
              RaisedButton(
                shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                child: Text('Calc Weight', softWrap: true, textAlign: TextAlign.center),
                onPressed: () =>  widget._brewWeightChanged(model.estimateBrewRatio(BrewRatioType.doseBrewWeight)))),

            ]),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              /// Dose
              RatioTextFieldItemWithInitalValue(
                widget._profile.getProfileItem(DatabaseIds.brewingDose), 
                (value){  if(!_filter.hasMatch(value)){
                widget._doseChanged(value);}}, 
                widget._isEditing,
                ),

              /// Yield
              RatioTextFieldItemWithInitalValue(
                widget._profile.getProfileItem(DatabaseIds.yielde), 
                (value){widget._yieldChanged(value);}, 
                widget._isEditing,
                ), 
              
              /// Brew wieght
              RatioTextFieldItemWithInitalValue(
                widget._profile.getProfileItem(DatabaseIds.brewWeight), 
                (value){widget._brewWeightChanged(value);}, 
                widget._isEditing,
              ),  
            ],
          ),

          Padding(padding: EdgeInsets.all(widget._margin)),

          DoseYieldBrewControl((value){  setState(() {
                      _brewRatioType = value;
                    });  }),

          Padding(padding: EdgeInsets.all(widget._margin)),

          Container(
          child:Text
          (Functions.getTwoNumberRatio(
          Functions.getIntValue(widget._profile.getProfileItemValue(DatabaseIds.brewingDose)),
          _brewRatioType == BrewRatioType.doseYield ?
           Functions.getIntValue(widget._profile.getProfileItemValue(DatabaseIds.yielde)) :
           Functions.getIntValue(widget._profile.getProfileItemValue(DatabaseIds.brewWeight))),
          style: Theme.of(context).textTheme.display3,),),

          Container(
            child:  _brewRatioType == BrewRatioType.doseYield ? 
            Text('Dose : Yield',style: Theme.of(context).textTheme.caption, ):
            Text('Dose : Brew Weight',style: Theme.of(context).textTheme.caption, )            ,
          ),

          Padding(padding: EdgeInsets.all(widget._margin)),

        ],
      ),
    )));
  }
}

///Two textFieldcard
class TwoTextfieldCard extends StatefulWidget {
  final double _padding = 10.0;
  final Item _itemRight;
  final bool _isEditing;
  final double _extractionYield;
  
  final Function(String) _onRightTextChanged;

  TwoTextfieldCard(
      this._onRightTextChanged,
      this._itemRight,
      this._isEditing,
      this._extractionYield
     );

  _TwoTextfieldCardState createState() => _TwoTextfieldCardState();
}
class _TwoTextfieldCardState extends State<TwoTextfieldCard> {

  TextEditingController _rightController = new TextEditingController();

  @override
    void initState() {
        _rightController.text = widget._itemRight.value;     
        super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Card(child: Container(

        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                Padding(padding: EdgeInsets.all(widget._padding/2)),

                // Right
                TextFieldItemWithInitalValue(
                  widget._itemRight,
                  (value){
                     if (Functions.countChacters(value,'.')>1)
                              {PopUps.showAlert(StringLabels.error,
                               'Only one decimel can be used.', 
                               StringLabels.ok, 
                               (){Navigator.pop(context);},
                              context);}

                              else{widget._onRightTextChanged(value);}
                    },
                  100.0, 
                  widget._isEditing,
                  textInputFormatters: [
                    BlacklistingTextInputFormatter
                      (new RegExp('[\\,]'), replacementString: '.',)]),

                Container(  margin: EdgeInsets.all(widget._padding),
                width: 140,child: 
                TextfieldWithFixedValue
                (StringLabels.extractionYield, 
                widget._extractionYield.toString()+'%',
                width: 140.0,),),

                Padding(padding: EdgeInsets.all(widget._padding/2)),
                ],
              ),
            ]),
      ),
    );
  }
}

class DoseYieldBrewControl extends StatefulWidget {

  final Function(BrewRatioType) _brewRatioTypeFunction;

  DoseYieldBrewControl(this._brewRatioTypeFunction);

  @override
  _DoseYieldBrewControlState createState() => _DoseYieldBrewControlState();
}
enum BrewRatioType{doseYield, doseBrewWeight}
class _DoseYieldBrewControlState extends State<DoseYieldBrewControl> {

  int _groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return  
      CupertinoSegmentedControl(
            groupValue: _groupValue,
            selectedColor: Theme.of(context).primaryColor,
            unselectedColor:  Theme.of(context).primaryColorLight,
            borderColor:  Theme.of(context).primaryColorDark,
            onValueChanged: (intValue){ setState((){
              assert(intValue < 2, 'INt value is too hight' );
              _groupValue = intValue;
              switch (intValue) {
                case 0: widget._brewRatioTypeFunction(BrewRatioType.doseYield); break;
                case 1: widget._brewRatioTypeFunction(BrewRatioType.doseBrewWeight); break;
                default: Error();
              }
            });}
              ,
      children:{
          0 : Container(padding: EdgeInsets.all(5.0),child:Text('Dose/Yield',style: Theme.of(context).textTheme.body2,),),
          1 : Container(padding: EdgeInsets.all(5.0),child:Text('Dose/Brew Weight',style: Theme.of(context).textTheme.body2,))
      }
    );
  }
}

/// Notes card
class NotesCard extends StatefulWidget {
  final double _padding = 10.0;
  final double _margin = 10.0;
  final Function(String) _onTextChanged;
  final String _title;
  final String _notes;
  final bool _isEditing;

  NotesCard(this._title, this._notes, this._onTextChanged, this._isEditing);
  _NotesCardState createState() => _NotesCardState();
}
class _NotesCardState extends State<NotesCard> {

  TextEditingController controller;

  void initState() { 
    controller = new TextEditingController(text: this.widget._notes);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
      height: 200.0,
      margin: EdgeInsets.all(widget._margin),
      padding: EdgeInsets.all(widget._padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Text(widget._title),
          Container(
            child: TextField(
              enabled: widget._isEditing,
              controller: controller,
              textAlign: TextAlign.start,
              maxLines: null,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintText: StringLabels.enterInfo,
              ),
              onChanged: widget._onTextChanged)
            )
          ],
        ),
      )
    );
  }
}


