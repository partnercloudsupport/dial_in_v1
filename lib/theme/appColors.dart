import 'package:flutter/material.dart';


class AppColors {

  static Color getColor(ColorType font) {
    Color returnValue;

    switch ( font ) {

      case ColorType.background:
        returnValue = Colors.black12;
        break;

        case ColorType.tint:
        returnValue = Colors.orange.shade500;
        break;

        case ColorType.button:
        returnValue = Colors.orange.shade500;
        break;

        case ColorType.white:
        returnValue = Colors.white70;
        break;

        case ColorType.toolBar:
        returnValue = Colors.black87;
        break;

        case ColorType.popupBackground:
        returnValue = Colors.black26;
        break;

        case ColorType.primarySwatch:
        returnValue = Colors.orange;
        break;

        case ColorType.lightBackground:
        returnValue = Colors.white70;
        break;

        case ColorType.lightColor:
        returnValue = Colors.white70;
        break;

        case ColorType.textLight:
        returnValue = Colors.white70;
        break;

        case ColorType.textDark:
        returnValue = Colors.black87;
        break;

      default:
        returnValue = Colors.orange;
    }
    return returnValue;
  }
}

enum ColorType { background, tint, white , toolBar,  popupBackground, primarySwatch, button, lightBackground, lightColor, textLight, textDark}