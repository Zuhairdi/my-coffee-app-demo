import 'package:flutter/material.dart';

myColor() => MaterialColor(0xFF935D2A, customColor);
const int r = 147, g = 93, b = 42;
const Map<int, Color> customColor = {
  50: Color.fromRGBO(r, g, b, .1),
  100: Color.fromRGBO(r, g, b, .2),
  200: Color.fromRGBO(r, g, b, .3),
  300: Color.fromRGBO(r, g, b, .4),
  400: Color.fromRGBO(r, g, b, .5),
  500: Color.fromRGBO(r, g, b, .6),
  600: Color.fromRGBO(r, g, b, .7),
  700: Color.fromRGBO(r, g, b, .8),
  800: Color.fromRGBO(r, g, b, .9),
  900: Color.fromRGBO(r, g, b, 1),
};
