import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocalizedString {
  final String key;
  final Map<String, String> values;

  const LocalizedString({this.key, this.values});

  ///Translates string by locale from given context.
  ///You can get translation without passing context -
  ///then the last cached locale will be used.
  ///Translation without context is experimental !!!
  String get([BuildContext context]) {
    if (context != null) {
      return values[AutoLocalization.of(context).locale.toString()];
    }
    return values[AutoLocalization.lastCachedLocale.toString()];
  }
}
