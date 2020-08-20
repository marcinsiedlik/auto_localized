import 'package:auto_localized_generator/src/config/model/annotation_config.dart';
import 'package:auto_localized_generator/src/generator/templates/code_generator.dart';
import 'package:auto_localized_generator/src/model/locale_info.dart';
import 'package:auto_localized_generator/src/model/localized_string.dart';
import 'package:recase/recase.dart';

class LocalizedStringsGenerator implements CodeGenerator {
  final AnnotationConfig _config;
  final List<LocalizedString> _strings;

  const LocalizedStringsGenerator(this._config, this._strings);

  @override
  String generate() {
    final buffer = StringBuffer()
      ..writeln('@immutable')
      ..writeln('class ${_config.stringsClassName} {')
      ..writeln(_generateLocalizedStringDefinitions())
      ..writeln('}');

    return buffer.toString();
  }

  String _generateLocalizedStringDefinitions() {
    final buffer = StringBuffer();
    _strings.forEach((string) {
      buffer.writeln(_generateLocalizedStringDefinition(string));
    });
    return buffer.toString();
  }

  String _generateLocalizedStringDefinition(LocalizedString string) {
    final name = _config.convertStringsToCamelCase ? string.key.camelCase : string.key;
    final buffer = StringBuffer()
      ..writeln("static const $name = LocalizedString(")
      ..writeln("key: '${string.key}',")
      ..writeln("values: {")
      ..writeln(_generateValuesMapDeclaration(string.values))
      ..writeln("},")
      ..writeln(");");

    return buffer.toString();
  }

  String _generateValuesMapDeclaration(Map<LocaleInfo, String> map) {
    final buffer = StringBuffer();
    map.forEach((key, value) {
      buffer.writeln("'${key.toString()}' : '''$value''',");
    });
    return buffer.toString();
  }
}
