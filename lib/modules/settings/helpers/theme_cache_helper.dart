import 'package:flutter/material.dart';
//-------------------------------------
import 'package:social_x/core/ui/themes.dart';
import 'package:social_x/core/constants/hive_boxes.dart';
//-------------------------------------------------------

class ThemeCacheHelper {
  // private constructor for the singleton
  ThemeCacheHelper._();

  // ThemeCacheHelper singleton
  static ThemeCacheHelper instance = ThemeCacheHelper._();

  final _cachedData = HiveBoxes.prefsBox;

  ThemeData get cachedTheme {
    final darkModeEnabled = _cachedData.get(
      HiveBoxes.darkModeKey,
      defaultValue: false,
    );

    return darkModeEnabled ? darkTheme : lightTheme;
  }

  void cacheNewTheme(bool darkThemeEnabled) {
    _cachedData.put(HiveBoxes.darkModeKey, darkThemeEnabled);
  }
}
