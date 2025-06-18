import 'package:flutter/material.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static const LightAppBarTheme = AppBarTheme(
    elevation: 8,
    centerTitle: false,
    scrolledUnderElevation: 8,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
    titleTextStyle: TextStyle(
      fontSize: 18.8,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ); // AppBar Theme
  static const darkAppBarTheme = AppBarTheme(
    elevation: 8,
    centerTitle: false,
    scrolledUnderElevation: 8,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: TextStyle(
      fontSize: 18.8,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ); // AppBar Theme
}
