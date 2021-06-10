import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Lato',
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.white),
      headline2: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.indigo,
    accentColor: Colors.indigoAccent,
    primarySwatch: Colors.deepPurple,
  );
}

// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);
