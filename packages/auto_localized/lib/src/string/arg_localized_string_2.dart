import 'package:auto_localized/src/string/base/localized_string.dart';
import 'package:auto_localized/src/string/base/localized_string_args.dart';
import 'package:flutter/material.dart';

class ArgLocalizedString2 extends LocalizedString {
  const ArgLocalizedString2({
    required String key,
    required Map<String, String> values,
  }) : super(2, key: key, values: values);

  ///Translates string by locale from given [context].
  ///You can get translation without passing context -
  ///then the last cached locale will be used.
  ///(Wrapping [MaterialApp] with [AutoLocalizedApp] is required)
  ///Returns value with given [arg1], [arg2] applied.
  String get(
    String arg1,
    String arg2, [
    BuildContext? context,
  ]) =>
      getRaw(context)
          .replaceAll(LocalizedStringArgs.arg1, arg1)
          .replaceAll(LocalizedStringArgs.arg2, arg2);

  /// Translates string by locale like [get] method
  /// and wraps it with [Text] widget
  Widget text({
    required String arg1,
    required String arg2,
    Key? key,
    BuildContext? context,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) =>
      Text(
        get(arg1, arg2, context),
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

  factory ArgLocalizedString2.fromJson(Map<String, dynamic> map) {
    return ArgLocalizedString2(
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
