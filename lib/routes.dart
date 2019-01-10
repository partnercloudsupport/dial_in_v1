import 'package:flutter/material.dart';        
import 'package:flutter/cupertino.dart';
import 'package:dial_in_v1/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:dial_in_v1/data/strings.dart';
import 'package:dial_in_v1/theme/appColors.dart';
import 'package:dial_in_v1/data/profile.dart';
import 'package:dial_in_v1/database_functions.dart';
import 'package:dial_in_v1/data/images.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:dial_in_v1/data/item.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'dart:async';
import 'package:dial_in_v1/data/mini_classes.dart';
import 'package:flutter/services.dart';
import 'package:dial_in_v1/data/functions.dart';
import 'package:dial_in_v1/inherited_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:dial_in_v1/widgets/custom_widgets.dart';

class Routes{

  


}

enum RouteOption{

  slow

}

class SlowerRoute extends MaterialPageRoute{

  SlowerRoute(WidgetBuilder builder) : super(builder:builder);

@override
Duration get transitionDuration => const Duration(milliseconds: 1000);

@override
Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return super.buildTransitions(context, animation, secondaryAnimation, child);
  }
}

/// Custom page transitions
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

class SecondPageRoute extends CupertinoPageRoute {
  SecondPageRoute()
      : super(builder: (BuildContext context) => new SignUpPage());


  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new SignUpPage()
    );
    }
}

