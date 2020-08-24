import 'package:auto_localized_generator/src/model/locale_info.dart';

class AnnotationConfigLocale {
  static const languageCodeField = 'languageCode';
  static const countryCodeField = 'countryCode';
  static const translationsFilePathField = 'translationsFilePath';

  final LocaleInfo info;
  final Map<String, String> translations;

  const AnnotationConfigLocale(this.info, this.translations);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnnotationConfigLocale &&
          runtimeType == other.runtimeType &&
          info == other.info &&
          translations == other.translations;

  @override
  int get hashCode => info.hashCode ^ translations.hashCode;

  @override
  String toString() => 'AnnotationConfigLocale{'
      'localeInfo: $info, '
      'translations: $translations}';
}
