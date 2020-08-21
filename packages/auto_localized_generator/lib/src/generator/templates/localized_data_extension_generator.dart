import 'package:auto_localized_generator/src/generator/templates/code_generator.dart';

class LocalizedDataExtensionGenerator implements CodeGenerator {
  @override
  String generate() {
    final buffer = StringBuffer()
      ..writeln('extension AutoLocalizedContextExtension on BuildContext {')
      ..writeln('List<Locale> get supportedLocales => AutoLocalizedData.supportedLocales;')
      ..writeln()
      ..writeln('List<LocalizationsDelegate> get localizationsDelegates => AutoLocalizedData.localizationsDelegates;')
      ..writeln('}');

    return buffer.toString();
  }
}
