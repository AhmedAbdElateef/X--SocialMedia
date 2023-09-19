import 'dart:io';
import 'dart:ui';
//---------------
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//-----------------------------------------------------------
import 'package:social_x/core/constants/hive_boxes.dart';
//-------------------------------------------------------

class LocaleCacheHelper {
  // private constructor for the singleton
  LocaleCacheHelper._();

  // LocaleCacheHelper singleton
  static LocaleCacheHelper instance = LocaleCacheHelper._();

  final _cachedData = HiveBoxes.prefsBox;

  Locale get cachedLocale {
    final storedLangCode = _cachedData.get(
      HiveBoxes.appLangKey,
      defaultValue: _systemLangCode,
    );

    return Locale(storedLangCode);
  }

  String get _systemLangCode {
    final langCode = Platform.localeName.split("_").first;
    return AppLocalizations.supportedLocales.contains(Locale(langCode))
        ? langCode
        : "ar";
  }

  void cacheNewLocale(Locale newLocale) {
    _cachedData.put(HiveBoxes.appLangKey, newLocale.languageCode);
  }
}
