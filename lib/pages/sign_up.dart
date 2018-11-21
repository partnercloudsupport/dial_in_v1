import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';
import '../data/strings.dart';
import '../database_functions.dart';

class SignUpPage extends StatefulWidget{

@override
  _SignUpPageState createState() => new _SignUpPageState();
}


 class _SignUpPageState extends State<SignUpPage>{

  Image _userImage = Image.asset('assets/images/user.png');

  String _userName;
  TextEditingController _userNameController = new TextEditingController();

  String _email;
  TextEditingController _emailController = new TextEditingController();

  String _password;
  TextEditingController _passwordController = new TextEditingController();

  void onUsernameChange(){ _userName = _userNameController.text; }

  void onEmailChange(){ _email =_emailController.text; }

  void onPasswordChange(){ _password = _passwordController.text;}  

  void signUpButton(){  
    DatabaseFunctions.signUp(_email, _password, (success, error){ 

      if (success){   print('signed up');   }else{  print('fail');  }
      });
  }

                                  @override
  void initState() {
    _userNameController.addListener(onEmailChange); 
    _emailController.addListener(onEmailChange); 
    _passwordController.addListener(onPasswordChange);    
      super.initState();
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
          Container(  height: 30.0, width: 30.0, margin: EdgeInsets.all(20.0), padding: EdgeInsets.all(0.0),
            child: RawMaterialButton( onPressed: () => Navigator.pop(context), 
            child: Container(   decoration: BoxDecoration( image: DecorationImage( image: AssetImage('assets/images/back_icon.png'), fit: BoxFit.cover)),),),),
         
          new Center(
            child: Column(  mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[
              
                /// New User text
                Text(StringLabels.newUser,  style: TextStyle(color: Colors.black87, fontSize: 30.0),),

                ///User Picture
                Container( margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 25.0) , child: CircularPicture(_userImage, 100.0)),

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
                Container(  margin: EdgeInsets.all(20.0), child: ActionButton(StringLabels.signUp,() => Navigator.pop(context, (){}))),

              ],
            ),
          )
        ]
      )
    );
  }
}