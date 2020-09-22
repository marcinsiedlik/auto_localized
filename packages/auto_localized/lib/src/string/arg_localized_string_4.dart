import 'package:auto_localized/src/string/base/localized_string.dart';
import 'package:auto_localized/src/string/base/localized_string_args.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArgLocalizedString4 extends LocalizedString {
  const ArgLocalizedString4({
    String key,
    Map<String, String> values,
  }) : super(4, key: key, values: values);

  ///Translates string by locale from given [context].
  ///You can get translation without passing context -
  ///then the last cached locale will be used.
  ///(Wrapping [MaterialApp] with [AutoLocalizedApp] is required).
  ///Returns value with given [arg1], [arg2], [arg3], [arg4] applied.
  String get(
    String arg1,
    String arg2,
    String arg3,
    String arg4, [
    BuildContext context,
  ]) {
    assert(
      arg1 != null && arg2 != null && arg3 != null && arg4 != null,
      "Arguments for localized strings can't be null."
      " Occurred in key: $key",
    );
    return getRaw(context)
        .replaceAll(LocalizedStringArgs.arg1, arg1)
        .replaceAll(LocalizedStringArgs.arg2, arg2)
        .replaceAll(LocalizedStringArgs.arg3, arg3)
        .replaceAll(LocalizedStringArgs.arg4, arg4);
  }

  factory ArgLocalizedString4.fromJson(Map<String, dynamic> map) {
    return ArgLocalizedString4(
      key: map['key'] as String,
      values: (map['values'] as Map<String, dynamic>)
          .map((key, dynamic value) => MapEntry(key, value as String)),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'key': key,
      'values': values,
    };
  }
}
