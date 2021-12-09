// ignore_for_file: avoid_positional_boolean_parameters

import 'package:auto_localized/annotations.dart';
import 'package:auto_localized_generator/src/config/model/annotation_config_locale.dart';

class AnnotationConfig {
  static const localesField = 'locales';
  static const convertToCamelCaseField = 'convertToCamelCase';
  static const onBlankValueStrategyField = 'onBlankValueStrategy';
  static const generateGetterMethodsField = 'generateGetterMethods';
  static const generateOfKeyFactoriesField = 'generateOfKeyFactories';

  static const onBlankValueStrategyStringMap = {
    'OnBlankValueStrategy.ignore': OnBlankValueStrategy.ignore,
    'OnBlankValueStrategy.warning': OnBlankValueStrategy.warning,
    'OnBlankValueStrategy.error': OnBlankValueStrategy.error,
  };

  final String stringsClassName;
  final bool convertStringsToCamelCase;
  final OnBlankValueStrategy onBlankValueStrategy;
  final bool generateGetterMethods;
  final bool generateOfKeyFactories;
  final List<AnnotationConfigLocale> locales;

  const AnnotationConfig(
    this.stringsClassName,
    this.convertStringsToCamelCase,
    this.onBlankValueStrategy,
    this.generateGetterMethods,
    this.generateOfKeyFactories,
    this.locales,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnnotationConfig &&
          runtimeType == other.runtimeType &&
          stringsClassName == other.stringsClassName &&
          convertStringsToCamelCase == other.convertStringsToCamelCase &&
          onBlankValueStrategy == other.onBlankValueStrategy &&
          generateGetterMethods == other.generateGetterMethods &&
          generateOfKeyFactories == other.generateOfKeyFactories &&
          locales == other.locales;

  @override
  int get hashCode =>
      stringsClassName.hashCode ^
      convertStringsToCamelCase.hashCode ^
      onBlankValueStrategy.hashCode ^
      generateGetterMethods.hashCode ^
      generateOfKeyFactories.hashCode ^
      locales.hashCode;

  @override
  String toString() => 'AnnotationConfig{'
      'stringsClassName: $stringsClassName, '
      'convertStringsToCamelCase: $convertStringsToCamelCase, '
      'onBlankValueStrategy: $onBlankValueStrategy, '
      'generateGetterMethods: $generateGetterMethods, '
      'generateOfKeyFactories: $generateOfKeyFactories, '
      'locales: $locales}';
}
