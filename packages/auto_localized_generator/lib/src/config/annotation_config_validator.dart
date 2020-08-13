import 'package:auto_localized_generator/src/config/model/annotation_config.dart';
import 'package:auto_localized_generator/src/config/model/annotation_config_locale.dart';
import 'package:auto_localized_generator/src/exception/missing_translation_key_exception.dart';

class AnnotationConfigValidator {
  const AnnotationConfigValidator();

  void validate(AnnotationConfig config) {
    _assureKeysEqualityInLocales(config.locales);
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
}
