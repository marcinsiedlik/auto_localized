import 'package:auto_localized_generator/src/config/model/annotation_config.dart';
import 'package:auto_localized_generator/src/model/localized_string.dart';
import 'package:auto_localized_generator/src/model/mutable_localized_string.dart';

class ConfigToLocalizedStringsConverter {
  const ConfigToLocalizedStringsConverter();

  List<LocalizedString> map(AnnotationConfig config) {
    //Use keys of the first locale. After validation in
    //AnnotationConfigValidator it is certain that keys are identical
    final translationKeys = config.locales.first.translations.keys;
    final strings = translationKeys.map((key) => MutableLocalizedString.empty(key)).toList();

    for (final locale in config.locales) {
      locale.translations.forEach((key, value) {
        strings.firstWhere((e) => e.key == key)?.values[locale.info] = value;
      });
    }

    return strings.map((mutable) => LocalizedString.fromMutable(mutable)).toList();
  }
}
