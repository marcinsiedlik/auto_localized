import 'package:auto_localized/src/string/base/localized_string.dart';
import 'package:auto_localized/src/string/base/localized_string_args.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArgLocalizedString2 extends LocalizedString {
  const ArgLocalizedString2({
    String key,
    Map<String, String> values,
  }) : super(key: key, values: values);

  ///Translates string by locale from given [context].
  ///You can get translation without passing context -
  ///then the last cached locale will be used.
  ///(Wrapping [MaterialApp] with [AutoLocalizedApp] is required)
  ///Returns value with given [arg1], [arg2] applied.
  String get(
    String arg1,
    String arg2, [
    BuildContext context,
  ]) {
    assert(
      arg1 != null && arg2 != null,
      "Arguments for localized strings can't be null."
      " Occurred in key: $key",
    );
    return getRaw(context).replaceAll(LocalizedStringArgs.arg1, arg1).replaceAll(LocalizedStringArgs.arg2, arg2);
  }
}
