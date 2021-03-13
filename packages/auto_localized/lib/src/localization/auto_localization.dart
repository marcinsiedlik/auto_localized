// ignore_for_file: prefer_constructors_over_static_methods

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef LocaleUpdateCallback = void Function(Locale locale);

class AutoLocalization {
  final List<LocaleUpdateCallback> _onLocaleUpdateCallbacks = [];

  ///Current app Locale
  late Locale locale;

  static final AutoLocalization _instance = AutoLocalization._();

  static AutoLocalization get instance => _instance;

  AutoLocalization._();

  ///Updates locale, invokes locale change callbacks
  static void updateLocale(Locale locale) {
    instance.locale = locale;
    instance._onLocaleUpdateCallbacks
        .forEach((element) => element.call(locale));
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

  static AutoLocalization of(BuildContext context) {
    final localizations = Localizations.of<AutoLocalization>(
      context,
      AutoLocalization,
    );
    if (localizations == null) {
      throw FlutterError.fromParts([
        ErrorSummary('No AutoLocalization found.'),
        ErrorDescription(
            '${context.widget.runtimeType} widgets require AutoLocalization '
            'to be provided by a Localizations widget ancestor.'),
        ErrorHint(
            'Did you forget to add AutoLocalization localization delegate to '
            'MaterialApp widget?'),
        ...context.describeMissingAncestor(
          expectedAncestorType: AutoLocalization,
        )
      ]);
    }
    return localizations;
  }
}
