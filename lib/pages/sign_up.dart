import 'package:flutter/material.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'dart:io';
import 'package:dial_in_v1/data/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dial_in_v1/data/functions.dart';



class SignUpPage extends StatefulWidget{

@override
  _SignUpPageState createState() => new _SignUpPageState();
}


 class _SignUpPageState extends State<SignUpPage>{

  String _userImage = Images.userFirebase;

  TextEditingController _userNameController = new TextEditingController();

  TextEditingController _emailController = new TextEditingController();

  TextEditingController _passwordController = new TextEditingController();
 

  void signUpButton(){  

    DatabaseFunctions.signUp
    (_userNameController.text, _emailController.text, _passwordController.text,
    (success, message) {
      if(success){
        Navigator.pop(context, true);
      
        
      }else{
        PopUps.showAlert( 
          buttonFunction:() {Navigator.of(context).pop();},
          buttonText: StringLabels.ok ,
          title: StringLabels.warning,
          message: message,
          context: context);
      }
    });              
  }


///
/// UI Build
///
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[

          ///
          /// Background
          /// 
           Pagebackground(AssetImage('assets/images/cherriestwo.jpg')),

          ///
          /// Back icon
          /// 
          Container(  height: 30.0, width: 30.0, margin: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0), padding: EdgeInsets.all(0.0),
            child: RawMaterialButton( onPressed: () => Navigator.pop(context), 
            child: Container(   decoration: BoxDecoration( image: DecorationImage( image: AssetImage('assets/images/back_icon.png'), fit: BoxFit.cover)),),),),
         
          new Center(
            child: Column(  mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[
              
                /// New User text
                Text(StringLabels.newUser,  style: TextStyle(color: Colors.black87, fontSize: 30.0),),

                ///User Picture
                 InkWell(
                   child: Container( decoration: BoxDecoration(shape: BoxShape.circle),margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 25.0) , 
                    child:CircularPicture(_userImage, 100.0)
                    ),
                   onTap:(){ Functions.getimageFromCameraOrGallery(context,
                    (image){ setState(() {_userImage = image;});});}
                 ),
                

                /// Sign up details
                /// Username
                Text(StringLabels.userName, style: TextStyle( color: Colors.white70, fontWeight: FontWeight.w600),),
                TextFieldEntry(StringLabels.userName, _userNameController, false),
                /// Email
                Text(StringLabels.email, style: TextStyle( color: Colors.white70, fontWeight: FontWeight.w600),),
                TextFieldEntry(StringLabels.email, _emailController, false),
                /// Password
                Text(StringLabels.password, style: TextStyle( color: Colors.white70, fontWeight: FontWeight.w600),),
                TextFieldEntry(StringLabels.password, _passwordController, true),

                /// Signup button
                Container(  margin: EdgeInsets.all(20.0), 
                child: 
                ActionButton(StringLabels.signUp,
                signUpButton
                ),)

              ]
            ),
          )
        ]
      )
    );
  }
}