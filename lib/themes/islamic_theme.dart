import 'package:flutter/material.dart';

class IslamicTheme {
  static const Radius defaultRadius = Radius.circular(10);
  static const Color anotherBlack = Color.fromRGBO(32, 32, 32, 1);

  static final ThemeData whiteTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      toolbarHeight: 70,
      actionsIconTheme: IconThemeData(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(defaultRadius),
      ),
    ),
    fontFamily: "Poppins",
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
  );
}
