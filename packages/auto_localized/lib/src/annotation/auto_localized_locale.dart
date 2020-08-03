// ignore_for_file: always_require_non_null_named_parameters

class AutoLocalizedLocale {
  final String languageCode;
  final String countryCode;
  final String jsonFilePath;

  const AutoLocalizedLocale({
    this.languageCode,
    this.countryCode,
    this.jsonFilePath,
  }) : assert(languageCode != null && jsonFilePath != null);
}
