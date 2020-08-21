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
  String translate(LocalizedString string) => string.get(this);

  List<Locale> get supportedLocales => AutoLocalizedData.supportedLocales;

  List<LocalizationsDelegate> get localizationsDelegates => AutoLocalizedData.localizationsDelegates;
}

@immutable
class Strings {
  static const welcome = LocalizedString(
    key: 'welcome',
    values: {
      'pl': '''Witaj!''',
      'en_US': '''Welcome!''',
      'sk': '''Ahoj!''',
    },
  );

  static const testMessage = LocalizedString(
    key: 'test_message',
    values: {
      'pl': '''To jest testowa wiadomość w języku Polskim''',
      'en_US': '''This is a test message in English''',
      'sk': '''Toto je testovacia správa v Slovenčine''',
    },
  );
}
