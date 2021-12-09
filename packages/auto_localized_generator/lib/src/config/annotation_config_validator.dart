import 'package:auto_localized/annotations.dart';
import 'package:auto_localized_generator/src/config/model/annotation_config.dart';
import 'package:auto_localized_generator/src/config/model/annotation_config_locale.dart';
import 'package:auto_localized_generator/src/exception/forbidden_translation_key_exception.dart';
import 'package:auto_localized_generator/src/exception/missing_translation_key_exception.dart';
import 'package:auto_localized_generator/src/exception/translation_args_bad_order_exception.dart';
import 'package:auto_localized_generator/src/exception/translation_value_blank_exception.dart';
import 'package:auto_localized_generator/src/utils/logging.dart';
import 'package:auto_localized_generator/src/utils/string_extensions.dart';
import 'package:recase/recase.dart';

class AnnotationConfigValidator {
  const AnnotationConfigValidator();

  void validate(AnnotationConfig config) {
    _assureKeysEqualityInLocales(config.locales);
    _checkForBlankValues(config);
    _assureArgsCorrectOrderInLocales(config.locales);
    // Passing first locale because it doesn't matter at this point,
    // equality of keys in all locales is validated already
    _assertForbiddenKeysNotUsed(config);
  }

  void _assureKeysEqualityInLocales(List<AnnotationConfigLocale> locales) {
    for (var i = 0; i < locales.length - 1; i++) {
      if (i + 1 > locales.length - 1) {
        break;
      }
      _compareTwoLocalesKeys(locales[i], locales[i + 1]);
    }
  }

  void _compareTwoLocalesKeys(
      AnnotationConfigLocale first, AnnotationConfigLocale second) {
    first.translations.keys.forEach((key) {
      if (!second.translations.containsKey(key)) {
        throw MissingTranslationKeyException(first, second, key);
      }
    });
    //reverse key checking
    second.translations.keys.forEach((key) {
      if (!first.translations.containsKey(key)) {
        throw MissingTranslationKeyException(second, first, key);
      }
    });
  }

  void _checkForBlankValues(AnnotationConfig config) {
    if (config.onBlankValueStrategy == OnBlankValueStrategy.ignore) {
      return;
    }
    final raiseError =
        config.onBlankValueStrategy == OnBlankValueStrategy.error;

    config.locales.forEach((locale) {
      _assureLocaleValuesNotBlank(locale, raiseError);
    });
  }

  void _assureLocaleValuesNotBlank(
    AnnotationConfigLocale locale,
    bool raiseError,
  ) {
    locale.translations.forEach((key, value) {
      if (value.isBlank) {
        if (raiseError) {
          throw TranslationValueBlankException(locale, key);
        } else {
          Logger.warning(
            'Translation value for key: "$key" is blank or whitespaces only\n'
            'Found in translation file for locale: "${locale.info.toString()}""',
          );
        }
      }
    });
  }

  void _assureArgsCorrectOrderInLocales(List<AnnotationConfigLocale> locales) {
    locales.forEach((locale) {
      _validateArgsOrder(locale);
    });
  }

  void _validateArgsOrder(AnnotationConfigLocale locale) {
    const _args1 = ['{1}'];
    const _args2 = ['{1}', '{2}'];
    const _args3 = ['{1}', '{2}', '{3}'];
    const _args4 = ['{1}', '{2}', '{3}', '{4}'];

    locale.translations.forEach((key, value) {
      if ((value.contains('{5}') && !value.containsAll(_args4)) ||
          (value.contains('{4}') && !value.containsAll(_args3)) ||
          (value.contains('{3}') && !value.containsAll(_args2)) ||
          (value.contains('{2}') && !value.containsAll(_args1))) {
        throw TranslationArgsBadOrderException(locale.info, key, value);
      }
    });
  }

  void _assertForbiddenKeysNotUsed(AnnotationConfig config) {
    final forbiddenWords = config.generateOfKeyFactories
        ? <String>['allLocalizedStrings', 'ofKey', 'maybeOfKey']
        : <String>[];

    final forbiddenWordsAllCases =
        forbiddenWords.map(_mapWordToPopularCases).expand((list) => list);
    // Passing first locale because it doesn't matter at this point,
    // equality of keys in all locales is validated already
    config.locales.first.translations.keys.forEach((key) {
      if (forbiddenWordsAllCases.contains(key)) {
        throw ForbiddenTranslationKeyException(
          key,
          AnnotationConfig.generateOfKeyFactoriesField,
        );
      }
    });
  }

  List<String> _mapWordToPopularCases(String word) {
    final reCase = ReCase(word);
    return [
      word,
      reCase.camelCase,
      reCase.pascalCase,
      reCase.sentenceCase,
      reCase.snakeCase,
      reCase.dotCase,
      reCase.paramCase,
      reCase.pathCase,
      reCase.headerCase,
      reCase.titleCase,
    ];
  }
}
