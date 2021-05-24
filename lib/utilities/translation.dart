import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'assets.dart';
import 'constant.dart';

class Translation {
  String assetsLocalizationJson;
  Locale _locale;
  Map<dynamic, dynamic> _localizedValues;
  VoidCallback _onLocaleChangedCallback;

  Iterable<Locale> supportLocales() =>
      kSupportedLanguages.map<Locale>((lang) => Locale(lang, ''));

  String getText(String key) =>
      (_localizedValues == null || _localizedValues[key] == null)
          ? 'raw $key'
          : _localizedValues[key];

  String get currentLanguage => _locale?.languageCode ?? '';

  Locale get locale => _locale;

  // one time initialize;
  Future<void> init([String language]) async {
    if (_locale == null) {
      assetsLocalizationJson = language == 'id' ? Assets.langId : Assets.langEn;
      await setNewLanguage(language);
    }
  }

  Future<void> setNewLanguage([String newLanguage]) async {
    String language = newLanguage;

    if (language == "" || language == null) {
      //set default language

      language = 'id';
      assetsLocalizationJson = Assets.langId;
    }

    _locale = Locale(language, "");

    //Load string from json assets

    assetsLocalizationJson =
        currentLanguage == 'id' ? Assets.langId : Assets.langEn;

    var _jsonContent = await rootBundle.loadString(assetsLocalizationJson);

    _localizedValues = jsonDecode(_jsonContent);

    if (_onLocaleChangedCallback != null) {
      _onLocaleChangedCallback();
    }
  }

  set onLocalChangedCallback(VoidCallback callback) =>
      _onLocaleChangedCallback = callback;

  // ignore: type_annotate_public_apis
  get onLocalChanged => _onLocaleChangedCallback;

  // singleton factory
  static final Translation _translations = Translation._internal();

  factory Translation() => _translations;

  Translation._internal();
}

Translation translation = Translation();

class FallbackLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      DefaultMaterialLocalizations();
  @override
  bool shouldReload(_) => false;
}
