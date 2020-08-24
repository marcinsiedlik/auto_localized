// ignore_for_file: always_require_non_null_named_parameters

import 'package:auto_localized/annotations.dart';

///Defines locale for [AutoLocalized.locales].
///Used for associate [languageCode] and [country code]
///with [translationsFilePath].
class AutoLocalizedLocale {
  ///Language code that will be used in generated source
  ///Must be not-null and can't be blank
  final String languageCode;

  ///Country code that will be used in generated source
  ///This field is optional
  final String countryCode;

  ///Path to translations file that will be parsed during source generation.
  ///Must be not-null and can't be blank
  ///Supported file formats: `JSON`, `YAML`.
  final String translationsFilePath;

  const AutoLocalizedLocale({
    this.languageCode,
    this.countryCode,
    this.translationsFilePath,
  }) : assert(languageCode != null && translationsFilePath != null);
}
