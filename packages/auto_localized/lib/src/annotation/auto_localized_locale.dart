import 'package:auto_localized/annotations.dart';

///Defines locale for [AutoLocalized.locales].
///Used for associate [languageCode] and [country code]
///with [translationsFiles].
class AutoLocalizedLocale {
  ///Language code that will be used in generated source
  ///Can't be blank
  final String languageCode;

  ///Country code that will be used in generated source
  ///This field is optional
  final String? countryCode;

  ///List of paths to translations files that will be parsed during source
  ///generation. You can split your translations to as many dirs and files
  ///as wanted but keys needs to be unique across all of files.
  ///Can't be blank or empty
  ///Supported file formats: `JSON`, `YAML`.
  ///
  final List<String> translationsFiles;

  const AutoLocalizedLocale({
    required this.languageCode,
    this.countryCode,
    required this.translationsFiles,
  });
}
