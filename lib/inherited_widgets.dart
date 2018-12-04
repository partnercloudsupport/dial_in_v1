import 'package:flutter/material.dart';
import 'pages/log_in.dart';
import 'theme/app_theme.dart';
import 'pages/sign_up.dart';
import 'widgets/custom_widgets.dart';
// import 'package:camera/camera.dart';



class CameraWidget extends InheritedWidget {

  CameraWidget({Key key ,Widget child}): super(key:key, child: child);
  
  @override
  bool updateShouldNotify(CameraWidget oldWidget) => true;

  static CameraWidget of (BuildContext context) =>
    context.inheritFromWidgetOfExactType(CameraWidget) as CameraWidget;
}

class DateWidget extends InheritedWidget {

  DateWidget({Key key ,Widget child}): super(key:key, child: child);
  
  @override
  bool updateShouldNotify(DateWidget oldWidget) => true;

  static DateWidget of (BuildContext context) =>
    context.inheritFromWidgetOfExactType(DateWidget) as DateWidget;
}