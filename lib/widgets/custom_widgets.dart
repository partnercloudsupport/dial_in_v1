import 'package:flutter/material.dart';
import '../data/strings.dart';
import '../theme/appColors.dart';
import '../data/profile.dart';

///
/// Background
///
class Pagebackground extends StatelessWidget {
  final AssetImage _image;

  Pagebackground(this._image);

  @override
  Widget build(BuildContext context) {
    return

        /// Background
        new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: _image,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

///
/// Dial in logo
///
class DialInLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Image.asset('assets/images/DialInWhiteLogo.png',
          height: 50.0, width: 50.0),
    );
  }
}

///
///Text Field entry
///

class TextFieldEntry extends StatefulWidget {
  final String _placeholder;
  final TextEditingController _controller;
  final bool _obscureText;


  TextFieldEntry(this._placeholder, this._controller, this._obscureText);

  @override
  State<StatefulWidget> createState() {

    return _TextFieldEntryState();
  }
}

/// Textfield Entry
class _TextFieldEntryState extends State<TextFieldEntry> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200.0,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(0.0),
        alignment: const Alignment(0.0, 0.0),
        child: TextFormField(
            obscureText: widget._obscureText,
            controller: widget._controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(const Radius.circular(10.0))),
                filled: true,
                hintText: widget._placeholder,
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.grey.withOpacity(0.7))));
  }
}

class CircularPicture extends StatelessWidget {
  final Image _image;
  final double _size;

  CircularPicture(this._image, this._size);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15.0),
        child: _image,
        height: _size,
        width: _size);
  }
}


///
/// Action button
///
class ActionButton extends StatelessWidget {
  final String _buttonTitle;
  final void _buttonAction;

  ActionButton(this._buttonTitle, this._buttonAction);

  void actionButtonPressed() {
    print('login button pressed');
  }

  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.orange.shade600.withOpacity(0.6),
      child: Text(_buttonTitle,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0)),
      onPressed: () {
        actionButtonPressed();
        _buttonAction;
      },
    );
  }
}

///
/// Custom page transitions
///
class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}

class CustomToolbar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flex(direction: Axis.horizontal),
          SegmentControlButton('Social'),
          Flex(direction: Axis.horizontal),
          SegmentControlButton('Social'),
          Flex(direction: Axis.horizontal),
          SegmentControlButton('Social'),
          Flex(direction: Axis.horizontal),
          SegmentControlButton('Social'),
          Flex(direction: Axis.horizontal)
        ],
      ),
    );
  }
}

///Segmented control button
class SegmentControlButton extends StatelessWidget {
  final String text;
  // final Image image;

  SegmentControlButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      child: RawMaterialButton(
        onPressed: () => {},
        child: Column(
          children: <Widget>[
            Icon(Icons.add),
            Text(text, style: TextStyle(fontSize: 10.0))
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          ///
          /// User Image
          ///
          Container(
              child: Center(
                  child: CircularPicture(
                      Image.asset('assets/images/user.png'), 100.0))),

          Column(
            children: <Widget>[
              ///
              /// User name text
              ///
              Container(
                  margin: EdgeInsets.all(20.0),
                  child: Text(
                    StringLabels.userName,
                    style: TextStyle(fontSize: 20.0),
                  )),

              Container(
                child: Row(
                  children: <Widget>[
                    ///
                    /// Brew count
                    ///
                    Container(
                        padding: EdgeInsets.all(5.0),
                        child:

                            /// Title
                            Column(children: <Widget>[
                          Text(StringLabels.brewCount),

                          /// Value
                          CountLabel('B')
                        ])),

                    ///
                    ///Bean stash
                    ///
                    Container(
                        padding: EdgeInsets.all(5.0),
                        child:

                            ///Title
                            Column(children: <Widget>[
                          Text(StringLabels.beanStash),

                          /// Value
                          CountLabel('C')
                        ]))
                  ],
                ),
              )
            ],
          )
        ]));
  }
}

///Profile card
class ProfileCard extends StatelessWidget {
  
  final Profile profile;

  ProfileCard(this.profile);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(children: <Widget>[
      ///
      /// Profile picture
      ///
      Container(
          child: CircularPicture(profile.image, 60.0)),

      Expanded(
          child: Row(children: <Widget>[
        ///
        /// Main name and secondnary details
        ///
        Expanded(
            child: Container(
                padding: EdgeInsets.all(0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(10.0), child: Text(profile.properties[0].value.toString())),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text(profile.properties[1].value.toString()),
                      )
                    ]))),

        ///
        /// Third and fourth details
        ///
        Expanded(
            child: Container(
                padding: EdgeInsets.all(0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(10.0), child: Text(profile.properties[2].value.toString())),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text(profile.properties[3].value.toString()),
                      )
                    ])))
      ]))
    ]));
  }
}

///Profile card
class SocialProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(children: <Widget>[
      ///
      /// Profile picture
      ///
      Container(
          child: CircularPicture(Image.asset('assets/images/user.png'), 60.0)),

      Expanded(
          child: Row(children: <Widget>[
        ///
        /// Main name and secondnary details
        ///
        Expanded(
            child: Container(
                padding: EdgeInsets.all(0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(10.0), child: Text('Main')),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text('Second'),
                      )
                    ]))),

        ///
        /// Third and fourth details
        ///
        Expanded(
            child: Container(
                padding: EdgeInsets.all(0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(10.0), child: Text('Third')),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text('Fourth'),
                      )
                    ])))
      ]))
    ]));
  }
}

class CountLabel extends StatelessWidget {
  final String _text;

  CountLabel(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.0),
        child: Text(
          _text,
          style: TextStyle(
              color: AppColors.getColor(ColorType.primarySwatch),
              fontSize: 20.0),
        ));
  }
}

///
/// Add floating action button
///

class AddButton extends StatelessWidget {

  final Function _onPressed;

  AddButton(this._onPressed);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onPressed,
      child: Icon(Icons.add),
    );
  }
}




////////////////////////////////// Custom Classes ///////////////////////////////////////



///
/// Tab View Data
class TabViewData{

  Widget screen;
  Tab tab;
  
  TabViewData(this.screen, this.tab);

}

class TabViewDataArray{

  List<TabViewData> ref;

 TabViewDataArray(this.ref);
}



class PopUps{
///
/// Show alert
/// 

static Future<void> showAlert({String title, String message, String buttonText, Function buttonFunction, BuildContext context }) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(buttonText),
            onPressed: () {
              buttonFunction();
              // Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}