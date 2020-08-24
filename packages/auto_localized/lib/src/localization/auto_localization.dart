import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef LocaleUpdateCallback = void Function(Locale locale);

class AutoLocalization {
  final Locale locale;

  AutoLocalization(this.locale) {
    lastCachedLocale = locale;
    _onLocaleUpdateCallbacks.forEach((callback) => callback.call(locale));
  }

  ///Updated when [AutoLocalization] constructor is called - locale changed.
  ///Used for translation without [BuildContext] (experimental).
  ///Field initializes with null, use with null checks.
  static Locale lastCachedLocale;

  static final List<LocaleUpdateCallback> _onLocaleUpdateCallbacks = [];

  ///Adds the callback with updated [Locale] when [AutoLocalization]
  ///constructor is called.
  static void addOnLocaleChangeCallback(LocaleUpdateCallback onChange) {
    _onLocaleUpdateCallbacks.add(onChange);
  }

  ///Removes callback added in [addOnLocaleChangeCallback].
  static void removeOnLocaleChangeCallback(LocaleUpdateCallback onChange) {
    _onLocaleUpdateCallbacks.remove(onChange);
  }

  static AutoLocalization of(BuildContext context) => Localizations.of<AutoLocalization>(context, AutoLocalization);
}
