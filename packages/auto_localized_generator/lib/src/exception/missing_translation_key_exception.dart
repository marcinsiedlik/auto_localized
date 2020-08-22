import 'package:auto_localized_generator/src/config/model/annotation_config_locale.dart';

class MissingTranslationKeyException implements Exception {
  final AnnotationConfigLocale locale;
  final AnnotationConfigLocale missingInLocale;
  final String missingKey;

  const MissingTranslationKeyException(this.locale, this.missingInLocale, this.missingKey);

  @override
  String toString() => 'An key: "$missingKey" is found in JSON file '
      'for language: "${locale.info.toString()}" but is missing '
      'in  "${missingInLocale.info.toString()}". Inspect these '
      'files and insert missing keys';
}
