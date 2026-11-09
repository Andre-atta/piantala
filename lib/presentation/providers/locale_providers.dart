import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_providers.g.dart';

const _localeKey = 'app_locale';

@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  @override
  Locale build() {
    _loadSavedLocale();
    return const Locale('it');
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_localeKey);
    if (languageCode != null &&
        (languageCode == 'it' || languageCode == 'en')) {
      state = Locale(languageCode);
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (locale.languageCode != 'it' && locale.languageCode != 'en') return;
    state = locale;
    await (await SharedPreferences.getInstance())
        .setString(_localeKey, locale.languageCode);
  }
}
