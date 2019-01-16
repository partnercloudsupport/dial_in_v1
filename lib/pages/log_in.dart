import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';
import 'package:dial_in_v1/pages/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dial_in_v1/pages/overview_page/overview_page.dart';
import 'package:dial_in_v1/database_functions.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _LoginPageState createState() => new _LoginPageState();
}

/// UI View
class _LoginPageState extends State<LoginPage> {
  String _email = "";
  TextEditingController _emailController = new TextEditingController();

  String _password = "";
  TextEditingController _passwordController = new TextEditingController();

  /// Functions
  void forgotPassword() {
    print(" Forgot password button pressed");
  }

  Future<void> logIn(String emailUser, String password,
      Function(bool, String) completion) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailUser, password: password);
      completion(true, StringLabels.loggedIn);
    } catch (e) {
      completion(false, e.message);
    }
  }

  void loginButtonPressed() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));

    logIn(_email, _password, (success, error) {
      Navigator.pop(context);

      if (success) {
        setState(() {
          _email = '';
          _password = '';
          _emailController.text = '';
          _passwordController.text = '';
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => OverviewPage()));
      } else {
        PopUps.showAlert(StringLabels.warning, error, StringLabels.ok, () {
          Navigator.of(context).pop();
        }, context);
      }
    });
  }

  Color gradientStart =
      Colors.deepPurple[700]; //Change start gradient color here
  Color gradientEnd = Colors.purple[500];

  void signUpButtonPressed() {
    Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => SignUpPage()))
        .then((details) {
      if(details != null){

        if (details[DatabaseIds.success]) {
          this._email = details[DatabaseIds.email];
          this._password = details[DatabaseIds.password];

          loginButtonPressed();
        } else {
          PopUps.showAlert(StringLabels.warning,
              'Error when logging in with sign up details', StringLabels.ok, () {
            Navigator.of(context).pop();
          }, context);
        }  
      }
    });
  }

  void onEmailChange() {
    _email = _emailController.text;
  }

  void onPasswordChange() {
    _password = _passwordController.text;
  }

  @override
  void initState() {
    _emailController.addListener(onEmailChange);
    _passwordController.addListener(onPasswordChange);
    tryToLogIn();

    super.initState();
  }

  ///TODO;
  void tryToLogIn() async {
    var user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => OverviewPage()));
    }
  }

  ///
  /// UI Build
  ///
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          // Pagebackground(AssetImage('assets/images/cherries.jpg')),
          // Material(color: Colors.amber,),

          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [gradientStart, gradientEnd],
                  begin: const FractionalOffset(0.5, 0.0),
                  end: const FractionalOffset(0.0, 0.5),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),

          Center(child: 
            ScalableWidget(
              Container(child:

                  /// View components
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  
                  Padding(
                    padding: EdgeInsets.all(20.0),
                  ),

                  /// Logo
                  DialInLogo(),

                  // Welcome text
                  Container(
                    width: 230.0,
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment(0.0, 0.0),
                    child: Text(StringLabels.welcomeToDialIn,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.white70, fontSize: 23.0)),
                  ),

                  // Instructions
                  Container(
                    width: 260.0,
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment(0.0, 0.0),
                    child: Text(StringLabels.logInWithDetails,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70)),
                  ),

                  // Email field
                  TextFieldEntry(StringLabels.email, _emailController, false),

                  // Password
                  TextFieldEntry(
                      StringLabels.password, _passwordController, true),

                  // Forgotton password
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: FlatButton(
                        child: Text(StringLabels.forgottonPassword,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600)),
                        onPressed: () {
                          setState(() {
                            forgotPassword();
                          });
                        }),
                  ),

                  /// Login button
                  LoginButton(loginButtonPressed),

                  Container(
                      margin: const EdgeInsets.all(15.0),
                      child: Center(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                            // Text
                            Container(
                                margin: const EdgeInsets.all(0.0),
                                child: Text(StringLabels.dontHaveAccount,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10.0))),

                            // Sign up button
                            SignUpButton(signUpButtonPressed)
                          ])))
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}

/// Login button
class LoginButton extends StatelessWidget {
  final Function loginAction;

  LoginButton(this.loginAction);

  Widget build(BuildContext context) {
    return RaisedButton(
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.orange.shade600.withOpacity(0.6),
        child: Text(StringLabels.logIn,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0)),
        onPressed: loginAction);
  }
}

/// Sign up Button
class SignUpButton extends StatelessWidget {
  final Function _onPressed;

  SignUpButton(this._onPressed);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(0.0),
      child: MaterialButton(
          child: Text(StringLabels.signUp,
              style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w300)),
          onPressed: _onPressed),
    );
  }
}
