import 'package:auto_localized/annotations.dart';
import 'package:auto_localized_generator/src/config/model/annotation_config.dart';
import 'package:auto_localized_generator/src/config/model/annotation_config_locale.dart';
import 'package:auto_localized_generator/src/exception/missing_translation_key_exception.dart';
import 'package:auto_localized_generator/src/exception/translation_value_blank_exception.dart';
import 'package:auto_localized_generator/src/utils/logging.dart';
import 'package:auto_localized_generator/src/utils/string_extensions.dart';

class AnnotationConfigValidator {
  const AnnotationConfigValidator();

  void validate(AnnotationConfig config) {
    _assureKeysEqualityInLocales(config.locales);
    _checkForBlankValues(config);
  }

  void _assureKeysEqualityInLocales(List<AnnotationConfigLocale> locales) {
    for (var i = 0; i < locales.length - 1; i++) {
      if (i + 1 > locales.length - 1) {
        break;
      }
      _compareTwoLocalesKeys(locales[i], locales[i + 1]);
    }
  }

  void _compareTwoLocalesKeys(AnnotationConfigLocale first, AnnotationConfigLocale second) {
    for (final key in first.translations.keys) {
      if (!second.translations.containsKey(key)) {
        throw MissingTranslationKeyException(first, second, key);
      }
    }
    //reverse key checking
    for (final key in second.translations.keys) {
      if (!first.translations.containsKey(key)) {
        throw MissingTranslationKeyException(second, first, key);
      }
    }
  }

  void _checkForBlankValues(AnnotationConfig config) {
    if (config.onBlankValueStrategy == OnBlankValueStrategy.ignore) {
      return;
    }
    final raiseError = config.onBlankValueStrategy == OnBlankValueStrategy.error;

    for (final locale in config.locales) {
      _assureLocaleValuesNotBlank(locale, raiseError);
    }
  }

  void _assureLocaleValuesNotBlank(AnnotationConfigLocale locale, bool raiseError) {
    locale.translations.forEach((key, value) {
      if (value.isBlank) {
        if (raiseError) {
          throw TranslationValueBlankException(locale, key);
        } else {
          Logger.warning(
            'Translation value for key: "$key" is blank.\n'
            'Found in JSON file for locale: "${locale.info.toString()}""',
          );
        }
      }
    });
  }
}
