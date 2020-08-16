import 'package:auto_localized_generator/src/config/model/annotation_config.dart';
import 'package:auto_localized_generator/src/model/localized_string.dart';

class ConfigToLocalizedStringsConverter {
  List<LocalizedString> map(AnnotationConfig config) {
    final localizedStrings = config.locales.first.translations.keys.map((e) => LocalizedString(e, {}));

    for (final locale in config.locales) {
      locale.translations.forEach((key, value) {
        localizedStrings.firstWhere((e) => e.key == key)?.values[locale.info] = value;
      });
    }

    return localizedStrings.toList();
  }
}
