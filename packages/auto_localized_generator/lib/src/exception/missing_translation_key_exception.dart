import 'package:auto_localized_generator/src/config/model/initial_config_locale.dart';

class MissingTranslationKeyException implements Exception {
  final InitialConfigLocale locale;
  final InitialConfigLocale missingInLocale;
  final String missingKey;

  const MissingTranslationKeyException(this.locale, this.missingInLocale, this.missingKey);

  @override
  String toString() => 'An key: "$missingKey" is found in JSON file '
      'for language: "${locale.info.languageCode}" but is missing '
      'in  "${missingInLocale.info.languageCode}". Inspect these '
      'files and insert missing keys';
}
