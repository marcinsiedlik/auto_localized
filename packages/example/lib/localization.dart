import 'package:auto_localized/annotations.dart';

@AutoLocalized(
  convertToCamelCase: true,
  onBlankValueStrategy: OnBlankValueStrategy.error,
  locales: [
    AutoLocalizedLocale(
      languageCode: 'pl',
      translationsFilePath: 'lang/pl.json',
    ),
    AutoLocalizedLocale(
      languageCode: 'en',
      countryCode: 'US',
      translationsFilePath: 'lang/en.yaml',
    ),
    AutoLocalizedLocale(
      languageCode: 'sk',
      translationsFilePath: 'lang/sk.json',
    ),
  ],
)
class _$Strings {}
