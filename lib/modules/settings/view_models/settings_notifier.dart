import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_x/core/constants/urls.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/core/ui/themes.dart';
import 'package:social_x/modules/settings/helpers/locale_cache_helper.dart';
import 'package:social_x/modules/settings/helpers/theme_cache_helper.dart';

final settingsProvider = ChangeNotifierProvider.autoDispose((_) {
  return SettingsNotifier();
});

class SettingsNotifier extends ChangeNotifier {
  late Locale appLocale;
  late ThemeData appTheme;

  final _auth = FirebaseAuth.instance;
  final _themeCacheHelper = ThemeCacheHelper.instance;
  final _localeCacheHelper = LocaleCacheHelper.instance;

  SettingsNotifier() {
    appTheme = _themeCacheHelper.cachedTheme;
    appLocale = _localeCacheHelper.cachedLocale;
  }

  void shareApp() {
    Share.share(Urls.playStoreLink);
  }

  void changeAppLang(Locale newLocale) {
    _localeCacheHelper.cacheNewLocale(newLocale);
    appLocale = newLocale;
    notifyListeners();
  }

  void changeAppTheme(bool darkModeEnabled) {
    _themeCacheHelper.cacheNewTheme(darkModeEnabled);
    appTheme = darkModeEnabled ? darkTheme : lightTheme;
    notifyListeners();
  }

  void logout() {
    _auth.signOut();
    Sailor.startOverFromRoute(AppRoutes.login);
  }
}
