import 'package:flutter/widgets.dart';

abstract class LocaleUtils {
  /// Restituisce il codice della lingua corrente ('it', 'en', ecc.).
  /// Attualmente hardcodato a 'it', ma predisposto per leggere
  /// dal Localizations.localeOf(context).languageCode in futuro.
  static String currentLocaleCode(BuildContext? context) {
    if (context != null) {
      try {
        return Localizations.localeOf(context).languageCode;
      } catch (_) {
        // Fallback in caso di assenza di Localizations nel widget tree
        return 'it';
      }
    }
    return 'it';
  }
}
