import 'package:auto_localized_generator/src/config/model/annotation_config.dart';
import 'package:auto_localized_generator/src/model/localized_string.dart';

class AutoLocalizedCodeGenerator {
  final AnnotationConfig _config;
  final List<LocalizedString> _strings;

  AutoLocalizedCodeGenerator(this._config, this._strings);
}
