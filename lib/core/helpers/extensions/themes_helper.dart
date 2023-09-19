import 'package:flutter/material.dart';
//-------------------------------------

extension ThemesHelper on BuildContext {
  bool get darkMoodEnabled {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark;
  }
}
