import 'package:auto_localized/src/localization/auto_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AutoLocalizationDelegate extends LocalizationsDelegate<AutoLocalization> {
  final List<Locale> supportedLocales;

  const AutoLocalizationDelegate(this.supportedLocales);

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  Future<AutoLocalization> load(Locale locale) => Future.value(AutoLocalization(locale));

  @override
  bool shouldReload(LocalizationsDelegate<AutoLocalization> old) => false;
}
