import 'package:auto_localized_generator/src/config/model/annotation_config_locale.dart';

class TranslationValueBlankException implements Exception {
  final AnnotationConfigLocale locale;
  final String blankValueKey;

  const TranslationValueBlankException(this.locale, this.blankValueKey);

  @override
  String toString() => 'Translation value for key: "$blankValueKey" is blank. '
      'Found in JSON file for locale: "${locale.info.toString()}"" ';
}
