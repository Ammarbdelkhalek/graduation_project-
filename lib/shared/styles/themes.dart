import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';
ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: defaultColor,
    selectionColor:  defaultColor,
    selectionHandleColor:  defaultColor,
  ),
  primaryColor: defaultColor,
  //primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('#333739'),
  appBarTheme: AppBarTheme(

    foregroundColor: Colors.white,
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('#333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    elevation:20.0,
    color: HexColor('#333739'),
    titleTextStyle: const TextStyle(
      decorationColor: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.greenAccent),
    tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.greenAccent,
      labelColor: Colors.white,
    ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.white,
    elevation: 10.0,
    backgroundColor: HexColor('#333739'),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  fontFamily: 'Jannah',
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
    foregroundColor: Colors.white,
  ),
  cardColor: HexColor('#333739'),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white),
    iconColor: Colors.white,
  ),
);

ThemeData lightTheme = ThemeData(
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: defaultColor,
    selectionColor: defaultColor,
    selectionHandleColor: defaultColor,
  ),
  // primarySwatch: defaultColor,
  primaryColor: defaultColor,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.greenAccent),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Jannah',
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
);
