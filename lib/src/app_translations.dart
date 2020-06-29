import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:newsexecise/src/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppTranslations {
  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  AppTranslations(Locale locale) {
    this.locale = locale;
    _localisedValues = null;
  }

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  static Future<AppTranslations> load(Locale locale) async {
    AppTranslations appTranslations = AppTranslations(locale);
    String jsonContent = await rootBundle
        .loadString("assets/locale/localization_${locale.languageCode}.json");
    //print(jsonContent);
    //print('Before ${locale.languageCode}');
    _localisedValues = json.decode(jsonContent);
    //print('After');

    print(locale.languageCode);
    if (_localisedValues == null) print('Its null');
    return appTranslations;
  }

  get currentLanguage => locale.languageCode;

  String text(String key) {
    return _localisedValues == null
        ? ''
        : (_localisedValues[key] ?? "$key not found");
  }

  List<String> textArray(String key) {
    if (_localisedValues == null)
      return ['', '', '', '', '', '', '', '', '', '', '', ''];
    else
      return _localisedValues[key] != null
          ? List.from(_localisedValues[key])
          : [];
  }
}

class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  final Locale newLocale;

  const AppTranslationsDelegate({
    this.newLocale,
  });

  @override
  bool isSupported(Locale locale) {
    return application.supportedLanguages.keys.contains(locale.languageCode);
  }

  @override
  Future<AppTranslations> load(Locale locale) {
    return AppTranslations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslations> old) {
    return true;
  }
}
