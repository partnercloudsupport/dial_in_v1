import 'package:flutter/material.dart';
import 'package:dial_in_v1/pages/log_in.dart';
import 'package:dial_in_v1/theme/app_theme.dart';
import 'package:dial_in_v1/pages/sign_up.dart';
import 'widgets/custom_widgets.dart';
import 'package:dial_in_v1/inherited_widgets.dart';

void main() {
  runApp(new MyApp());
}
 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return     
    new MaterialApp(
      title: 'Flutter Demo',
      theme: buildThemeData(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),

      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/': return new MyCustomRoute(
            builder: (_) => new MyHomePage(),
            settings: settings,
          );
          case '/signup': return new MyCustomRoute(
            builder: (_) => new SignUpPage(),
            settings: settings,
          );
        }
        assert(false);
      }
    );
  }
}

