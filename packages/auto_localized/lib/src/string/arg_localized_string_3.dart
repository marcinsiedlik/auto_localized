import 'package:auto_localized/src/string/base/localized_string.dart';
import 'package:auto_localized/src/string/base/localized_string_args.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArgLocalizedString3 extends LocalizedString {
  const ArgLocalizedString3({
    String key,
    Map<String, String> values,
  }) : super(key: key, values: values);

  ///Translates string by locale from given [context].
  ///You can get translation without passing context -
  ///then the last cached locale will be used.
  ///(Wrapping [MaterialApp] with [AutoLocalizedApp] is required).
  ///Returns value with given [arg1], [arg2], [arg3] applied.
  String get(
    String arg1,
    String arg2,
    String arg3, [
    BuildContext context,
  ]) {
    assert(
      arg1 != null && arg2 != null && arg3 != null,
      "Arguments for localized strings can't be null."
      " Occurred in key: $key",
    );
    return getRaw(context)
        .replaceAll(LocalizedStringArgs.arg1, arg1)
        .replaceAll(LocalizedStringArgs.arg2, arg2)
        .replaceAll(LocalizedStringArgs.arg3, arg3);
  }
}
