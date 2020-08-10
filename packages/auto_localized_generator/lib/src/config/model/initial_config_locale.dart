import 'package:auto_localized_generator/src/model/locale_info.dart';

class InitialConfigLocale {
  final LocaleInfo info;
  final Map<String, String> translations;

  const InitialConfigLocale(this.info, this.translations);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InitialConfigLocale &&
          runtimeType == other.runtimeType &&
          info == other.info &&
          translations == other.translations;

  @override
  int get hashCode => info.hashCode ^ translations.hashCode;

  @override
  String toString() => 'InitialConfigLocale{'
      'localeInfo: $info, '
      'translations: $translations}';
}
