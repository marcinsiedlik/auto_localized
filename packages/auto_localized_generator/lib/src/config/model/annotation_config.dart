// ignore_for_file: avoid_positional_boolean_parameters

import 'package:auto_localized/annotations.dart';
import 'package:auto_localized_generator/src/config/model/annotation_config_locale.dart';

class AnnotationConfig {
  static const localesField = 'locales';
  static const convertToCamelCaseField = 'convertToCamelCase';
  static const onBlankValueStrategyField = 'onBlankValueStrategy';

  static const onBlankValueStrategyStringMap = {
    'OnBlankValueStrategy.ignore': OnBlankValueStrategy.ignore,
    'OnBlankValueStrategy.warning': OnBlankValueStrategy.warning,
    'OnBlankValueStrategy.error': OnBlankValueStrategy.error,
  };

  final String stringsClassName;
  final bool convertStringsToCamelCase;
  final OnBlankValueStrategy onBlankValueStrategy;
  final List<AnnotationConfigLocale> locales;

  const AnnotationConfig(
    this.stringsClassName,
    this.convertStringsToCamelCase,
    this.onBlankValueStrategy,
    this.locales,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnnotationConfig &&
          runtimeType == other.runtimeType &&
          convertStringsToCamelCase == other.convertStringsToCamelCase &&
          stringsClassName == other.stringsClassName &&
          locales == other.locales;

  @override
  int get hashCode =>
      convertStringsToCamelCase.hashCode ^
      stringsClassName.hashCode ^
      locales.hashCode;

  @override
  String toString() => 'AnnotationConfig{'
      'convertStringsToCamelCase: $convertStringsToCamelCase, '
      'stringsClassName: $stringsClassName, '
      'locales: $locales}';
}
