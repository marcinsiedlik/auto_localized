import 'package:auto_localized/annotations.dart';

@AutoLocalized(
  convertToCamelCase: true,
  generateGetterMethods: true,
  onBlankValueStrategy: OnBlankValueStrategy.error,
  locales: [
    AutoLocalizedLocale(
      languageCode: 'pl',
      translationsFiles: ['lang/pl.json'],
    ),
    AutoLocalizedLocale(
      languageCode: 'en',
      countryCode: 'US',
      translationsFiles: ['lang/en.yaml'],
    ),
    AutoLocalizedLocale(
      languageCode: 'sk',
      translationsFiles: ['lang/sk.json'],
    ),
  ],
)
class $Strings {}
