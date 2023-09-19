import 'package:flutter/material.dart';
//-------------------------------------
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//-----------------------------------------------------------

extension LocalizationHelper on BuildContext {
  /// Checks if current language is RTL.
  bool get isRTL => Localizations.localeOf(this).languageCode == "ar";

  /// Checks current language langCode.
  String get langCode => Localizations.localeOf(this).languageCode;

  /// Gets current language writing-system direction.
  TextDirection get textDirection {
    return Localizations.localeOf(this).languageCode == "ar"
        ? TextDirection.rtl
        : TextDirection.ltr;
  }

  /// Gets all localized messages.
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
