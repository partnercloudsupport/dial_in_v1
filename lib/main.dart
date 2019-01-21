import 'package:flutter/material.dart';
import 'package:dial_in_v1/pages/log_in.dart';
import 'package:dial_in_v1/theme/app_theme.dart';
import 'package:dial_in_v1/pages/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:dial_in_v1/routes.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
// import 'dart:developer';
// import 'package:flutter/rendering.dart';


void main() {
  ///Slow down animations
  timeDilation = 1.0;
  runApp(new MyApp());
  }
 
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    /// Layout shown ///
    // debugPaintSizeEnabled = true;

    ProfilesModel _profilesModel = ProfilesModel();

    return ScopedModel(
      model: _profilesModel,
      child:

    new MaterialApp(
      title: 'Login',
      theme: buildThemeData(),
      home: LoginPage(),

    /// Debugger
     showPerformanceOverlay: false, 
     checkerboardRasterCacheImages: false, 
     checkerboardOffscreenLayers: false, 
     showSemanticsDebugger: false,
     debugShowCheckedModeBanner: true,

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

