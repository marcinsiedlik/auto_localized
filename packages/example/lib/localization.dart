import 'package:auto_localized/annotations.dart';

@AutoLocalized(
  convertToCamelCase: true,
  onBlankValueStrategy: OnBlankValueStrategy.error,
  locales: [
    AutoLocalizedLocale(
      languageCode: 'pl',
      jsonFilePath: 'lang/pl.json',
    ),
    AutoLocalizedLocale(
      languageCode: 'en',
      countryCode: 'US',
      jsonFilePath: 'lang/en.json',
    ),
    AutoLocalizedLocale(
      languageCode: 'sk',
      jsonFilePath: 'lang/sk.json',
    ),
  ],
)
class _$Strings {}
