// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unnecessary_const, constant_identifier_names

// **************************************************************************
// AutoLocalizedGenerator
// **************************************************************************

import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class AutoLocalizedData {
  static const supportedLocales = <Locale>[
    Locale('pl'),
    Locale('en', 'US'),
    Locale('sk'),
  ];

  static const delegate = AutoLocalizationDelegate(supportedLocales);

  static const localizationsDelegates = [
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    delegate,
  ];
}

extension AutoLocalizedContextExtension on BuildContext {
  String translate(
    LocalizedString string, [
    String arg1 = "",
    String arg2 = "",
    String arg3 = "",
    String arg4 = "",
    String arg5 = "",
  ]) =>
      string.when(
        plain: (string) => string.get(this),
        arg1: (string) => string.get(arg1, this),
        arg2: (string) => string.get(arg1, arg2, this),
        arg3: (string) => string.get(arg1, arg2, arg3, this),
        arg4: (string) => string.get(arg1, arg2, arg3, arg4, this),
        arg5: (string) => string.get(arg1, arg2, arg3, arg4, arg5, this),
      );

  List<Locale> get supportedLocales => AutoLocalizedData.supportedLocales;

  List<LocalizationsDelegate> get localizationsDelegates => AutoLocalizedData.localizationsDelegates;
}

@immutable
class Strings {
  static const welcome = PlainLocalizedString(
    key: 'welcome',
    values: {
      'pl': '''Witaj!''',
      'en_US': '''Welcome!''',
      'sk': '''Ahoj!''',
    },
  );

  static const testMessage = PlainLocalizedString(
    key: 'test_message',
    values: {
      'pl': '''To jest testowa wiadomość w języku Polskim''',
      'en_US': '''This is a test message in English''',
      'sk': '''Toto je testovacia správa v Slovenčine''',
    },
  );

  static const welcomeName = ArgLocalizedString2(
    key: 'welcome_name',
    values: {
      'pl': '''Witaj {1}, {2}!''',
      'en_US': '''Welcome {1}, {2}!''',
      'sk': '''Ahoj {1}, {2}!''',
    },
  );
}
