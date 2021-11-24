import 'dart:ui';

import 'package:flutter/material.dart';

// final themeColor = Color.fromRGBO(FF, e2, 67, 1.0);
// final shadowColor = Color.fromRGBO(D9, DB, DF, 1.0);
// final homeColor = Color.fromRGBO(FF, FD, F6, 1.0);
// final appbarColor = Color.fromRGBO(00, 09, 24, 1.0);

// final themeColor = Color(0xffffe267);
final shadowColor = Color(0xffD9DBDF);
final homeColor = Color(0xffFFFDF6);
final appbarColor = Color(0xff000924);

const MaterialColor themeColor = MaterialColor(
  _themeColorPrimaryValue,
  <int, Color>{
    50: Color(0xffEEB08B),
    100: Color(0xffEEB08B),
    200: Color(0xffEEB08B),
    300: Color(0xffEEB08B),
    400: Color(0xffEEB08B),
    500: Color(_themeColorPrimaryValue),
    600: Color(0xffEEB08B),
    700: Color(0xffEEB08B),
    800: Color(0xffEEB08B),
    900: Color(0xffEEB08B),
  },
);
const int _themeColorPrimaryValue = 0xffffe267;

// const MaterialAccentColor themeColor = MaterialAccentColor(
//   _themeColorValue,
//   <int, Color>{
//     100: Color(0xFFFF8A80),
//     200: Color(_themeColorValue),
//     400: Color(0xFFFF1744),
//     700: Color(0xFFD50000),
//   },
// );
// const int _themeColorValue = 0xffffe267;