import 'package:flutter/material.dart';


class AppColors {

  static Color getColor(ColorType colorType) {
    Color returnValue;

    switch ( colorType ) {

      case ColorType.background:
        returnValue = Colors.black;
        break;

        case ColorType.tint:
        returnValue = const Color(0xffBC794D);
        break;

        case ColorType.button:
        returnValue = Colors.orange;
        break;

        case ColorType.white:
        returnValue = Colors.white;
        break;

        case ColorType.toolBar:
        returnValue = Colors.black;
        break;

        case ColorType.popupBackground:
        returnValue = Colors.black;
        break;

        case ColorType.primarySwatch:
        returnValue = const Color(0xffBC794D);
        break;

        case ColorType.lightBackground:
        returnValue = Colors.white;
        break;

        case ColorType.lightColor:
        returnValue = Colors.white;
        break;

        case ColorType.textLight:
        returnValue = Colors.white;
        break;

        case ColorType.textDark:
        returnValue = Colors.black;
        break;

      default:
        returnValue = const Color(0xffBC794D);
    }
    return returnValue;
  }
}

enum ColorType { background, tint, white , toolBar,  popupBackground, primarySwatch, button, lightBackground, lightColor, textLight, textDark}