import 'package:flutter/material.dart';

class ConstColors {
  static const Color yellow = Color(0xffFFC107);
  static const Color male = Color(0xff37b3cc);
  static const Color female = Color(0xfff37ea7);
  static const Color grey = Color.fromRGBO(138, 138, 138, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color noColor = Color.fromRGBO(0, 0, 0, 0);
  static const Color primaryColor = Color.fromRGBO(26, 188, 0, 0.8313725490196079);

//(26, 188, 0, 0.8313725490196079)

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
//
// static const MaterialColor materialColorGreen =
//     MaterialColor(0x1ABC00FF, <int, Color>{
//   50: Color.fromRGBO(255, 255, 255, 1.0),
//   100: Color.fromRGBO(26, 188, 0, 1.0),
//   200: Color.fromRGBO(26, 188, 0, 1.0),
//   300: Color.fromRGBO(26, 188, 0, 1.0),
//   400: Color.fromRGBO(26, 188, 0, 1.0),
//   500: Color.fromRGBO(26, 188, 0, 1.0),
//   600: Color.fromRGBO(26, 188, 0, 1.0),
//   700: Color.fromRGBO(26, 188, 0, 1.0),
//   800: Color.fromRGBO(26, 188, 0, 1.0),
//   900: Color.fromRGBO(26, 188, 0, 1.0),
// });
}
