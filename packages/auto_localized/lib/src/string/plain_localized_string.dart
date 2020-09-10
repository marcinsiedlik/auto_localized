import 'package:auto_localized/src/string/base/localized_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlainLocalizedString extends LocalizedString {
  const PlainLocalizedString({
    String key,
    Map<String, String> values,
  }) : super(key: key, values: values);

  ///Translates string by locale from given [context].
  ///You can get translation without passing context -
  ///then the last cached locale will be used.
  ///(Wrapping [MaterialApp] with [AutoLocalizedApp] is required)
  String get([BuildContext context]) => getRaw(context);
}
