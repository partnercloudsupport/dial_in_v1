import 'package:flutter/material.dart';        

class SlowerRoute extends MaterialPageRoute{


  SlowerRoute(WidgetBuilder builder) : super(builder:builder);

@override
Duration get transitionDuration => const Duration(milliseconds: 1000);

}
