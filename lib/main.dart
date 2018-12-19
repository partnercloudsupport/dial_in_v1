import 'package:flutter/material.dart';
import 'package:dial_in_v1/pages/log_in.dart';
import 'package:dial_in_v1/theme/app_theme.dart';
import 'package:dial_in_v1/pages/sign_up.dart';
import 'widgets/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';

void main() {runApp(new MyApp());}
 
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ProfilesModel(),
      child:

    new MaterialApp(
      title: 'Login',
      theme: buildThemeData(),
      home: LoginPage(),

      onGenerateRoute: (RouteSettings settings) {
        print(settings.name);
        switch (settings.name) {
          case '/': return new MyCustomRoute(
            builder: (_) => new LoginPage(),
            settings: settings,
          );
          case '/signup': return new MyCustomRoute(
            builder: (_) => new SignUpPage(),
            settings: settings,
          );
          case '/signup': 
        }
        assert(false);
      }
    )
    );
  }
}

