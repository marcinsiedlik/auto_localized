// ignore_for_file: prefer_constructors_over_static_methods

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef LocaleUpdateCallback = void Function(Locale locale);

class AutoLocalization {
  final List<LocaleUpdateCallback> _onLocaleUpdateCallbacks = [];

  ///Current app Locale
  Locale locale;

  static AutoLocalization _instance;

  static AutoLocalization get instance => _instance ?? (_instance = AutoLocalization._());

  AutoLocalization._();

  ///Updates locale, invokes locale change callbacks
  static void updateLocale(Locale locale) {
    instance.locale = locale;
    instance._onLocaleUpdateCallbacks.forEach((element) => element.call(locale));
  }

  ///Adds the callback with updated [Locale] when [AutoLocalization]
  ///constructor is called.
  static void addOnLocaleChangeCallback(LocaleUpdateCallback onChange) {
    instance._onLocaleUpdateCallbacks.add(onChange);
  }

  ///Removes callback added in [addOnLocaleChangeCallback].
  static void removeOnLocaleChangeCallback(LocaleUpdateCallback onChange) {
    instance._onLocaleUpdateCallbacks.remove(onChange);
  }

  static AutoLocalization of(BuildContext context) => Localizations.of<AutoLocalization>(context, AutoLocalization);
}
