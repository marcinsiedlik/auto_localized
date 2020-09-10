import 'package:auto_localized/auto_localized.dart';
import 'package:auto_localized/src/localization/auto_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class LocalizedString {
  final String key;
  final Map<String, String> values;

  const LocalizedString({@required this.key, @required this.values});

  ///Translates string by locale from given [context].
  ///You can get translation without passing context -
  ///then the last cached locale will be used.
  ///(Wrapping [MaterialApp] with [AutoLocalizedApp] is required)
  ///Returns raw value (without args applied).
  String getRaw([BuildContext context]) {
    return context != null
        ? values[AutoLocalization.of(context).locale.toString()]
        : values[AutoLocalization.instance.locale.toString()];
  }

  T when<T>({
    T Function(PlainLocalizedString string) plain,
    T Function(ArgLocalizedString1 string) arg1,
    T Function(ArgLocalizedString2 string) arg2,
    T Function(ArgLocalizedString3 string) arg3,
    T Function(ArgLocalizedString4 string) arg4,
    T Function(ArgLocalizedString5 string) arg5,
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
}
