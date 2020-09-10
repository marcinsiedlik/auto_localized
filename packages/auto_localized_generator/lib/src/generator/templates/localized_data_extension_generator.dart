import 'package:auto_localized_generator/src/generator/templates/code_generator.dart';

class LocalizedDataExtensionGenerator implements CodeGenerator {
  @override
  String generate() {
    final buffer = StringBuffer()
      ..writeln('extension AutoLocalizedContextExtension on BuildContext {')
      ..writeln()
      ..writeln(_translateFunctionDefinition)
      ..writeln()
      ..writeln(_supportedLocalesDefinition)
      ..writeln()
      ..writeln(_localizationsDelegatesDefinition)
      ..writeln('}');

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

  String get _supportedLocalesDefinition => 'List<Locale> get supportedLocales => AutoLocalizedData.supportedLocales;';

  String get _localizationsDelegatesDefinition =>
      'List<LocalizationsDelegate> get localizationsDelegates => AutoLocalizedData.localizationsDelegates;';
}
