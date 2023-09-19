import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
//--------------------------------------------------------
import 'package:social_x/core/ui/colors.dart';
//--------------------------------------------

class AppStyles {
  /// amount of shared horizontal padding on app screens.
  static const screensHorizontalPadding = 16.0;

  /// amount of shared padding used in most of app components.
  static const componentsPadding = 16.0;

  /// amount of shared border radius used in large-sized components.
  static const largeComponentsRadius = 12.0;

  /// amount of shared border radius used in small-sized components.
  static const smallComponentsRadius = 7.0;

  /// amount of empty white space left in the bottom of
  /// scrollable screens for better user experience.
  static const screenBottomSpace = SizedBox(height: 40.0);

  /// average animation duration recommended for user experience.
  static const animationDuration = Duration(milliseconds: 250);

  /// divider between [ListView]s on the app.
  static const listViewDivider = Divider(
    color: AppColors.grey70,
    height: 20,
    endIndent: 30,
    indent: 30,
    thickness: 0.5,
  );
}

class NavIconsStyle extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(fontSize: 20, color: color);
  }
}
