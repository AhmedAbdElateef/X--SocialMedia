import 'package:flutter/material.dart';
//-------------------------------------
import 'package:social_x/core/ui/colors.dart';
//--------------------------------------------

final lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: AppColors.grey70,
    errorColor: AppColors.errorColor,
  ),
  fontFamily: "CircularStd",
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: AppColors.grey70,
    errorColor: AppColors.errorColor,
    brightness: Brightness.dark,
  ),
  fontFamily: "CircularStd",
  scaffoldBackgroundColor: Colors.black,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
