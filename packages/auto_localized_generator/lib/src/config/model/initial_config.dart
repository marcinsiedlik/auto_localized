// ignore_for_file: avoid_positional_boolean_parameters

import 'package:auto_localized_generator/src/config/model/initial_config_locale.dart';

class InitialConfig {
  final bool convertStringsToCamelCase;
  final String stringsClassName;
  final List<InitialConfigLocale> locales;

  const InitialConfig(this.stringsClassName, this.convertStringsToCamelCase, this.locales);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InitialConfig &&
          runtimeType == other.runtimeType &&
          convertStringsToCamelCase == other.convertStringsToCamelCase &&
          stringsClassName == other.stringsClassName &&
          locales == other.locales;

  @override
  int get hashCode => convertStringsToCamelCase.hashCode ^ stringsClassName.hashCode ^ locales.hashCode;

  @override
  String toString() => 'InitialConfig{'
      'convertStringsToCamelCase: $convertStringsToCamelCase, '
      'stringsClassName: $stringsClassName, '
      'locales: $locales}';
}
