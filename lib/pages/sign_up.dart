import 'package:flutter/material.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/data/mini_classes.dart';


class SignUpPage extends StatefulWidget{

@override
  _SignUpPageState createState() => new _SignUpPageState();
}

 class _SignUpPageState extends State<SignUpPage>{

  String _userImage = Images.userFirebase;

  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  Color gradientStart = Colors.deepPurple[700]; //Change start gradient color here
  Color gradientEnd = Colors.purple[500];
 
  void signUpButton()async{

    showDialog(barrierDismissible: false, context: context ,
      builder: (context) => Center(child:CircularProgressIndicator()
      ));    

    await DatabaseFunctions.signUp
    (_userNameController.text,
    _emailController.text,
    _passwordController.text,
    _userImage,
    
    (success, message) {

      Navigator.pop(context);

      if(success){

        Map<String , dynamic> details ={
        DatabaseIds.success: success,
        DatabaseIds.email : _emailController.text,
        DatabaseIds.password : _passwordController.text}; 

        Navigator.pop(context, details);
      
      }else{
        PopUps.showAlert( 
        StringLabels.warning,
        message,
        StringLabels.ok ,
        (){Navigator.of(context).pop();},
        context);
      }
    }).catchError((message) => PopUps.showAlert( 
        StringLabels.warning,
        message,
        StringLabels.ok ,
        (){Navigator.of(context).pop();},
        context));              
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
          //  Pagebackground(AssetImage('assets/images/cherriestwo.jpg')),

        Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [gradientStart, gradientEnd],
                begin: const FractionalOffset(0.5, 0.0),
                end: const FractionalOffset(0.0, 0.5),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp
            ),
          ),
          ),

          ///
          /// Back icon
          /// 
          
         
          new ListView(
            children: <Widget>[

            Padding(padding: EdgeInsets.all(5.0),),
              
            Row(  mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[  

            Padding(padding: EdgeInsets.all(5.0),),

            SizedBox(height: 30.0, width: 30.0,
            child: RawMaterialButton( onPressed: () => Navigator.pop(context), 
            child: Container(decoration: BoxDecoration( 
              image: DecorationImage( 
                image: AssetImage('assets/images/back_icon.png'),
                 fit: BoxFit.fitHeight)),),),),

              Expanded(child: Container(),)
              ]),
              
               Column(  mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[

              
                /// New User text
                Text(StringLabels.newUser,  style: TextStyle(color: Colors.black87, fontSize: 30.0),),

                Padding(padding: EdgeInsets.all(5.0),),

                ///User Picture
                 InkWell(
                   child: Container( decoration: BoxDecoration(shape: BoxShape.circle),margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 25.0) , 
                    child:CircularPicture(_userImage, 150.0)
                    ),
                   onTap:(){ 
                    Functions.getimageFromCameraOrGallery(
                      context,
                      (String image){ setState(() {_userImage = image;});});
                   }
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
            ])
        ]
      )
    );
  }
}