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

  /// Translates string by locale like [get] method
  /// and wraps it with [Text] widget
  Widget text({
    Key key,
    BuildContext context,
    TextStyle style,
    StrutStyle strutStyle,
    TextAlign textAlign,
    TextDirection textDirection,
    Locale locale,
    bool softWrap,
    TextOverflow overflow,
    double textScaleFactor,
    int maxLines,
    String semanticsLabel,
    TextWidthBasis textWidthBasis,
    TextHeightBehavior textHeightBehavior,
  }) =>
      Text(
        get(context),
        key: key,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
      );

  factory PlainLocalizedString.fromJson(Map<String, dynamic> map) {
    return PlainLocalizedString(
      key: map['key'] as String,
      values: (map['values'] as Map<String, dynamic>).map((key, dynamic value) => MapEntry(key, value as String)),
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
