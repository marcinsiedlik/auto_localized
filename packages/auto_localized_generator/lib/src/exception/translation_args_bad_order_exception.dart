import 'package:auto_localized_generator/src/model/locale_info.dart';

class TranslationArgsBadOrderException implements Exception {
  final LocaleInfo localeInfo;
  final String invalidInKey;
  final String invalidValue;

  const TranslationArgsBadOrderException(this.localeInfo, this.invalidInKey, this.invalidValue);

  @override
  String toString() => 'Error while analyzing translation file for locale: '
      '"${localeInfo.toString()}", on key: "$invalidInKey", value: "$invalidValue" '
      '- order of args numbers is invalid. Arg numbers must start from 1 to 5 ';
}
