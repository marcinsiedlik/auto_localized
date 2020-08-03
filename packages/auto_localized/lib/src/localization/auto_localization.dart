import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef LocaleUpdateCallback = void Function(Locale locale);

class AutoLocalization {
  final Locale locale;

  AutoLocalization(this.locale) {
    lastCachedLocale = locale;
    for (final callback in _onLocaleUpdateCallbacks) {
      callback.call(locale);
    }
  }

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
