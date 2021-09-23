import 'package:flutter/material.dart';

final kPrimaryColor = MaterialColor(0xff6655ff, {
  50: Color(0xff6655ff).withAlpha(90),
  100: Color(0xff6655ff).withAlpha(90),
  200: Color(0xff6655ff).withAlpha(90),
  300: Color(0xff6655ff).withAlpha(90),
  400: Color(0xff6655ff).withAlpha(90),
  500: Color(0xff6655ff).withAlpha(90),
  600: Color(0xff6655ff).withAlpha(90),
  700: Color(0xff6655ff).withAlpha(90),
  750: Color(0xff6655ff).withAlpha(90),
  800: Color(0xff6655ff).withAlpha(90),
  900: Color(0xff6655ff).withAlpha(90),
});

final kSecondaryColor = MaterialColor(0xff54ffaa, {
  50: Color(0xff54ffaa).withAlpha(90),
  100: Color(0xff54ffaa).withAlpha(90),
  200: Color(0xff54ffaa).withAlpha(90),
  300: Color(0xff54ffaa).withAlpha(90),
  400: Color(0xff54ffaa).withAlpha(90),
  500: Color(0xff54ffaa).withAlpha(90),
  600: Color(0xff54ffaa).withAlpha(90),
  700: Color(0xff54ffaa).withAlpha(90),
  750: Color(0xff54ffaa).withAlpha(90),
  800: Color(0xff54ffaa).withAlpha(90),
  900: Color(0xff54ffaa).withAlpha(90),
});

final kMainTheme = ThemeData(
  primarySwatch: kPrimaryColor,
  primaryTextTheme: TextTheme(
    subtitle1: TextStyle(
      color: kPrimaryColor,
      fontSize: 13,
    ),
    bodyText2: TextStyle(
      fontSize: 7,
    ),
  ),
  iconTheme: IconThemeData(
    color: kSecondaryColor,
    size: 13,
  ),
);
