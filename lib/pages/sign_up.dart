import 'package:flutter/material.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'dart:io';
import 'package:dial_in_v1/database_functions.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _userImage;

  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  Color gradientStart =
      Colors.deepPurple[700]; //Change start gradient color here
  Color gradientEnd = Colors.purple[500];

  void signUpButton() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));

    await Dbf.signUp(
        _userNameController.text,
        _emailController.text,
        _passwordController.text,
        _userImage, (success, message) {
      Navigator.pop(context);

      if (success) {
        Map<String, dynamic> details = {
          DatabaseIds.success: success,
          DatabaseIds.email: _emailController.text,
          DatabaseIds.password: _passwordController.text
        };

        Navigator.pop(context, details);
      } else {
        PopUps.showAlert(StringLabels.warning, message, StringLabels.ok, () {
          Navigator.of(context).pop();
        }, context);
      }
    }).catchError((message) =>
        PopUps.showAlert(StringLabels.warning, message, StringLabels.ok, () {
          Navigator.of(context).pop();
        }, context));
  }

  void savePicture(){
    Functions.getimageFromCameraOrGallery(context,
      (String image)async{
      PopUps.showCircularProgressIndicator(context);
      String url = await Dbf.upLoadFileReturnUrl(File(image), ['NewUserImages']).catchError((e) => print(e));
      Navigator.pop(context);
      setState(() {
        _userImage = url;
      });
    });
  }
  

  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(children: <Widget>[

      SignUpLoginBackground(),
      
      SafeArea(
              child: Stack(children: <Widget>[

        
          new Container(child: 
            
            ListView(children: <Widget>[

              Padding(padding: EdgeInsets.all(20.0),),

                /// New User text
                Center(child:Text(
                  StringLabels.newUser,
                  style: TextStyle(color: Colors.black87, fontSize: 30.0),
                )),

                Padding(
                  padding: EdgeInsets.all(10.0),
                ),

                ///User Picture
                 Center(child:InkWell(
                    child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 25.0),
                        child: CircularCachedProfileImage(Images.user, _userImage, 150.0, '')),
                    onTap: savePicture)),

                /// Sign up details
                /// Username
                Center(child:
                Text(
                  StringLabels.userName,
                  style: TextStyle( fontWeight: FontWeight.w600),
                )),
                TextFieldEntry(StringLabels.userName, _userNameController, false),

                /// Email
                Center(child: Text(
                  StringLabels.email,
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
                TextFieldEntry(StringLabels.email, _emailController, false),

                /// Password
                Center(child: Text(
                  StringLabels.password,
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
                TextFieldEntry(StringLabels.password, _passwordController, true),

                /// Signup button
                 Center(child:Container(
                  margin: EdgeInsets.all(20.0),
                  child: ActionButton(StringLabels.signUp, signUpButton),
                )),

                Padding(padding: EdgeInsets.all(20.0),),

            ])),

          BackIcon( () {if (_userImage !=null ){ Dbf.deleteFireBaseStorageItem(_userImage); }})
   
        ],),
      )
    ])
    );
  }
}

class BackIcon extends StatelessWidget {
  
  final Function _deleteIfNeeded;

  BackIcon(this._deleteIfNeeded);

  @override
  Widget build(BuildContext context) =>
    Container(
          margin: EdgeInsets.all(20.0),
          height: 30.0,
          width: 30.0,
          child: RawMaterialButton(
            onPressed: () { _deleteIfNeeded(); Navigator.pop(context); },
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/back_icon.png'),
                      fit: BoxFit.fitHeight)),
            ),
          ),
        );
}
