import 'package:auto_localized_generator/src/config/model/annotation_config.dart';
import 'package:auto_localized_generator/src/generator/templates/code_generator.dart';
import 'package:auto_localized_generator/src/model/localized_string.dart';
import 'package:recase/recase.dart';

class LocalizedDataExtensionGenerator implements CodeGenerator {
  final AnnotationConfig _config;
  final List<LocalizedString> _strings;

  const LocalizedDataExtensionGenerator(this._config, this._strings);

  @override
  String generate() {
    final buffer = StringBuffer();
    buffer.writeln('extension AutoLocalizedContextExtension on BuildContext {');
    buffer.writeln();
    buffer.writeln(_supportedLocalesDefinition);
    buffer.writeln();
    buffer.writeln(_localizationsDelegatesDefinition);
    buffer.writeln();
    buffer.writeln(_translateFunctionDefinition);
    buffer.writeln();
    if (_config.generateGetterMethods) {
      buffer.writeln(_generateLocalizedStringGetters());
      buffer.writeln();
    }
    buffer.writeln('}');

    return buffer.toString();
  }

  String get _translateFunctionDefinition => '''
  String translate(
    LocalizedString string, [
    String arg1 = "",
    String arg2 = "",
    String arg3 = "",
    String arg4 = "",
    String arg5 = "",
  ]) =>
      string.when(
        plain: (string) => string.get(this),
        arg1: (string) => string.get(arg1, this),
        arg2: (string) => string.get(arg1, arg2, this),
        arg3: (string) => string.get(arg1, arg2, arg3, this),
        arg4: (string) => string.get(arg1, arg2, arg3, arg4, this),
        arg5: (string) => string.get(arg1, arg2, arg3, arg4, arg5, this),
      );
  ''';

  String get _supportedLocalesDefinition =>
      'List<Locale> get supportedLocales => AutoLocalizedData.supportedLocales;';

  String get _localizationsDelegatesDefinition =>
      'List<LocalizationsDelegate> get localizationsDelegates => AutoLocalizedData.localizationsDelegates;';

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
          "String get${string.key.pascalCase}${string.type.getterContextExtensionParams}")
      ..write(" => ")
      ..writeln(
          "${_config.stringsClassName}.$name.get${string.type.getterContextExtensionArgs};");

    return buffer.toString();
  }
}
