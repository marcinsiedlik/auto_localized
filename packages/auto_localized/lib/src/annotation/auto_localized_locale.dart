// ignore_for_file: always_require_non_null_named_parameters

class AutoLocalizedLocale {
  ///Language code that will be used in generated source
  ///Must be not-null and can't be blank
  final String languageCode;

  ///Country code that will be used in generated source
  ///This field is optional
  final String countryCode;

  ///Path to JSON file that will be parsed during source generation.
  ///Must be not-null and can't be blank
  final String jsonFilePath;

  const AutoLocalizedLocale({
    this.languageCode,
    this.countryCode,
    this.jsonFilePath,
  }) : assert(languageCode != null && jsonFilePath != null);
}
