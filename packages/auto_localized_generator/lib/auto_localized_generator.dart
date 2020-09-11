import 'package:analyzer/dart/element/element.dart';
import 'package:auto_localized/annotations.dart';
import 'package:auto_localized_generator/builder.dart';
import 'package:auto_localized_generator/src/config/annotation_config_resolver.dart';
import 'package:auto_localized_generator/src/converter/config_to_localized_strings_converter.dart';
import 'package:auto_localized_generator/src/generator/auto_localized_code_generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

///Code generator for [AutoLocalized] annotation, used by [autoLocalized].
class AutoLocalizedGenerator extends GeneratorForAnnotation<AutoLocalized> {
  @override
  Future generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final config =
        await AnnotationConfigResolver(element, annotation, buildStep)
            .resolve();
    final strings = const ConfigToLocalizedStringsConverter().map(config);

    return AutoLocalizedCodeGenerator(config, strings).generate();
  }
}
