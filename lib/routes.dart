import 'package:flutter/material.dart';        


class Routes{

  


}

enum RouteOption{

  slow

}



class SlowerRoute extends MaterialPageRoute{


  SlowerRoute(WidgetBuilder builder) : super(builder:builder);

@override
Duration get transitionDuration => const Duration(milliseconds: 1000);


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