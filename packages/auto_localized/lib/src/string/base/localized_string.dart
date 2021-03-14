import 'package:auto_localized/auto_localized.dart';
import 'package:auto_localized/src/localization/auto_localization.dart';
import 'package:auto_localized/src/string/type/localized_string_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class LocalizedString {
  final int id;
  final String key;
  final Map<String, String> values;

  const LocalizedString(
    this.id, {
    required this.key,
    required this.values,
  });

  ///Translates string by locale from given [context].
  ///You can get translation without passing context -
  ///then the last cached locale will be used.
  ///(Wrapping [MaterialApp] with [AutoLocalizedApp] is required)
  ///Returns raw value (without args applied).
  String getRaw([BuildContext? context]) {
    final text = context != null
        ? values[AutoLocalization.of(context).locale.toString()]
        : values[AutoLocalization.instance.locale.toString()];

    if (text == null) {
      throw FlutterError('AutoLocalized: value for $key is null. This should '
          'never happen, you can fill bug report on github');
    }
    return text;
  }

  T when<T>({
    required T Function(PlainLocalizedString string) plain,
    required T Function(ArgLocalizedString1 string) arg1,
    required T Function(ArgLocalizedString2 string) arg2,
    required T Function(ArgLocalizedString3 string) arg3,
    required T Function(ArgLocalizedString4 string) arg4,
    required T Function(ArgLocalizedString5 string) arg5,
  }) {
    if (this is PlainLocalizedString) {
      return plain(this as PlainLocalizedString);
    } else if (this is ArgLocalizedString1) {
      return arg1(this as ArgLocalizedString1);
    } else if (this is ArgLocalizedString2) {
      return arg2(this as ArgLocalizedString2);
    } else if (this is ArgLocalizedString3) {
      return arg3(this as ArgLocalizedString3);
    } else if (this is ArgLocalizedString4) {
      return arg4(this as ArgLocalizedString4);
    } else {
      return arg5(this as ArgLocalizedString5);
    }
  }

  factory LocalizedString.fromJson(Map<String, dynamic> map) {
    final key = map['key'] as String;

    final translations = (map['values'] as Map<String, dynamic>)
        .map((key, dynamic value) => MapEntry(key, value as String));

    final type = LocalizedStringType.resolveFromValues(translations.values);

    return type.when(
      plain: (_) => PlainLocalizedString(key: key, values: translations),
      arg1: (_) => ArgLocalizedString1(key: key, values: translations),
      arg2: (_) => ArgLocalizedString2(key: key, values: translations),
      arg3: (_) => ArgLocalizedString3(key: key, values: translations),
      arg4: (_) => ArgLocalizedString4(key: key, values: translations),
      arg5: (_) => ArgLocalizedString5(key: key, values: translations),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'key': key,
      'values': values,
    };
  }
}
