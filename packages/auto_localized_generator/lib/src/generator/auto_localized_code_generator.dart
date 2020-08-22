import 'package:auto_localized_generator/src/config/model/annotation_config.dart';
import 'package:auto_localized_generator/src/generator/templates/code_generator.dart';
import 'package:auto_localized_generator/src/generator/templates/imports_generator.dart';
import 'package:auto_localized_generator/src/generator/templates/localized_data_extension_generator.dart';
import 'package:auto_localized_generator/src/generator/templates/localized_data_generator.dart';
import 'package:auto_localized_generator/src/generator/templates/localized_strings_generator.dart';
import 'package:auto_localized_generator/src/model/localized_string.dart';

class AutoLocalizedCodeGenerator {
  final List<CodeGenerator> _generators;

  AutoLocalizedCodeGenerator(AnnotationConfig config, List<LocalizedString> strings)
      : _generators = [
          ImportsGenerator(),
          LocalizedDataGenerator(config.locales),
          LocalizedDataExtensionGenerator(),
          LocalizedStringsGenerator(config, strings),
        ];

  String generate() {
    final buffer = StringBuffer();

    _generators.forEach((generator) {
      buffer.writeln(generator.generate());
    });

    return buffer.toString();
  }
}
