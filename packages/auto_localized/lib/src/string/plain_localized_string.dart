import 'package:auto_localized/src/string/base/localized_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlainLocalizedString extends LocalizedString {
  const PlainLocalizedString({
    String key,
    Map<String, String> values,
  }) : super(0, key: key, values: values);

  ///Translates string by locale from given [context].
  ///You can get translation without passing context -
  ///then the last cached locale will be used.
  ///(Wrapping [MaterialApp] with [AutoLocalizedApp] is required)
  String get([BuildContext context]) => getRaw(context);

  factory PlainLocalizedString.fromJson(Map<String, dynamic> map) {
    return PlainLocalizedString(
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
