import 'package:auto_localized_generator/src/config/model/annotation_config_locale.dart';
import 'package:auto_localized_generator/src/generator/templates/code_generator.dart';
import 'package:auto_localized_generator/src/model/locale_info.dart';

class LocalizedDataGenerator implements CodeGenerator {
  final List<AnnotationConfigLocale> _locales;

  LocalizedDataGenerator(this._locales);

  static const delegates = [
    'GlobalWidgetsLocalizations.delegate',
    'GlobalMaterialLocalizations.delegate',
    'GlobalCupertinoLocalizations.delegate',
    'delegate',
  ];

  @override
  String generate() {
    final buffer = StringBuffer()
      ..writeln('@immutable')
      ..writeln('class AutoLocalizedData {')
      ..writeln(_generateSupportedLocales())
      ..writeln(_generateDelegateDeclaration())
      ..writeln(_generateLocalizationsDelegates())
      ..writeln('}');

    return buffer.toString();
  }

  String _generateSupportedLocales() {
    final buffer = StringBuffer();

    buffer.writeln('static const supportedLocales = <Locale>[');
    _locales.forEach((locale) {
      buffer.writeln('${_generateLocaleConstructor(locale.info)},');
    });
    buffer.writeln('];');

    return buffer.toString();
  }

  String _generateDelegateDeclaration() => 'static const delegate = AutoLocalizationDelegate(supportedLocales);\n';

  String _generateLocalizationsDelegates() {
    final buffer = StringBuffer();

    buffer.writeln('static const localizationsDelegates = [');
    delegates.forEach((delegate) {
      buffer.writeln('$delegate,');
    });
    buffer.writeln('];');

    return buffer.toString();
  }

  String _generateLocaleConstructor(LocaleInfo info) => "Locale("
      "'${info.languageCode}'"
      "${info.countryCode != null ? ",'${info.countryCode}'" : ''}"
      ")";
}
