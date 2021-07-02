import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Lato',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.indigo,
    accentColor: Colors.indigoAccent,
    primarySwatch: Colors.deepPurple,
  );
}

ThemeData darkThemeData(BuildContext context) {
  // Bydefault flutter provie us light and dark theme
  // we just modify it as our need
  return ThemeData.dark().copyWith(
    //textTheme: TextTheme(  ),
    primaryColor: Colors.white70,
  //  scaffoldBackgroundColor: kContentColorLightTheme,
    //appBarTheme: appBarTheme,
   // iconTheme: IconThemeData(color: kContentColorDarkTheme),
  //  textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
  //      .apply(bodyColor: kContentColorDarkTheme),
    /*colorScheme: ColorScheme.dark().copyWith(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kContentColorLightTheme,
      selectedItemColor: Colors.white70,
      unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),*/
  );
}

// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);
