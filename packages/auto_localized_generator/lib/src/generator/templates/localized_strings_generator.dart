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
    final buffer = StringBuffer();
    buffer.writeln('@immutable');
    buffer.writeln('class ${_config.stringsClassName} {');
    buffer.writeln('const ${_config.stringsClassName}._();');
    buffer.writeln(_generateLocalizedStringDefinitions());
    if (_config.generateGetterMethods) {
      buffer.writeln(_generateLocalizedStringGetters());
    }
    if (_config.generateOfKeyFactories) {
      buffer.writeln(_generateAllLocalizedStringsList());
      buffer.writeln(_generateOfKeyFactories());
    }
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateLocalizedStringDefinitions() {
    final buffer = StringBuffer();
    _strings.forEach((string) {
      buffer.writeln(_generateLocalizedStringDefinition(string));
    });
    return buffer.toString();
  }

  String _generateLocalizedStringGetters() {
    final buffer = StringBuffer();
    _strings.forEach((string) {
      buffer.writeln(_generateLocalizedStringGetterMethod(string));
    });
    return buffer.toString();
  }

  String _generateLocalizedStringGetterMethod(LocalizedString string) {
    final name =
        _config.convertStringsToCamelCase ? string.key.camelCase : string.key;
    final buffer = StringBuffer()
      ..write(
          "static String get${string.key.pascalCase}${string.type.getterParams}")
      ..write(" => ")
      ..writeln("$name.get${string.type.getterArgs};");

    return buffer.toString();
  }

  String _generateLocalizedStringDefinition(LocalizedString string) {
    final name = _getKeyNameInProperCase(string.key);
    final buffer = StringBuffer()
      ..writeln("static const $name = ${string.type.name}(")
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

  String _generateAllLocalizedStringsList() {
    final buffer = StringBuffer();
    buffer.writeln('static const allLocalizedStrings = <LocalizedString>[');
    _strings.forEach((string) {
      final name = _getKeyNameInProperCase(string.key);
      buffer.writeln('$name,');
    });
    buffer.writeln('];');
    return buffer.toString();
  }

  String _generateOfKeyFactories() {
    final buffer = StringBuffer();
    buffer.writeln(
        '/// Returns an abstract version of [LocalizedString] based on given key');
    buffer.writeln('/// or null if not exists.');
    buffer.writeln('static LocalizedString? maybeOfKey(String key) {');
    buffer.writeln('try {');
    buffer.writeln(
        'return allLocalizedStrings.firstWhere((string) => string.key == key);');
    buffer.writeln('} catch (_) {');
    buffer.writeln('return null;');
    buffer.writeln('}');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln(
        '/// Returns an abstract version of [LocalizedString] based on given key');
    buffer.writeln('/// or throws an [Exception] if not exist');
    buffer.writeln('static LocalizedString ofKey(String key) {');
    buffer.writeln('final localized = maybeOfKey(key);');
    buffer.writeln('if (localized != null) return localized;');
    buffer.writeln('throw LocalizedStringNotFoundException(key);');
    buffer.writeln('}');
    buffer.writeln();

    return buffer.toString();
  }

  String _getKeyNameInProperCase(String key) =>
      _config.convertStringsToCamelCase ? key.camelCase : key;
}
