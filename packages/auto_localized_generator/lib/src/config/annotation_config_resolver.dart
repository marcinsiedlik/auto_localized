import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:auto_localized/annotations.dart';
import 'package:auto_localized_generator/src/asset/asset_reader.dart';
import 'package:auto_localized_generator/src/config/annotation_config_validator.dart';
import 'package:auto_localized_generator/src/config/model/annotation_config.dart';
import 'package:auto_localized_generator/src/config/model/annotation_config_locale.dart';
import 'package:auto_localized_generator/src/model/locale_info.dart';
import 'package:auto_localized_generator/src/utils/string_extensions.dart';
import 'package:build/build.dart' hide AssetReader;
import 'package:source_gen/source_gen.dart';

class AnnotationConfigResolver {
  final Element _element;
  final ConstantReader _annotation;
  final AssetReader _assetReader;

  AnnotationConfigResolver(this._element, this._annotation, BuildStep buildStep)
      : _assetReader = AssetReader(buildStep);

  Future<AnnotationConfig> resolve() async {
    final className = _resolveClassName();
    final convertToCamelCase = _resolveConvertToCamelCase();
    final onBlankValueStrategy = _resolveOnBlankValueStrategy();
    final generateGetterMethods = _resolveGenerateGetterMethods();
    final generateOfKeyFactories = _resolveGenerateOfKeyFactories();
    final locales = await _resolveLocales();

    final config = AnnotationConfig(
      className,
      convertToCamelCase,
      onBlankValueStrategy,
      generateGetterMethods,
      generateOfKeyFactories,
      locales,
    );

    //Validation of created config, throws Exception on invalid config
    const AnnotationConfigValidator().validate(config);

    return config;
  }

  String _resolveClassName() {
    _throwSourceErrorIf(
      condition: () => _element is! ClassElement,
      message: '${_element.name} is not a class element',
    );
    _throwSourceErrorIf(
      condition: () => _element.name == null,
      message: 'Class name is null',
    );
    _throwSourceErrorIf(
      condition: () => _element.name!.length <= 1,
      message: '${_element.name} is too short',
    );
    _throwSourceErrorIf(
      condition: () => _element.name!.substring(0, 1) != '\$',
      message: '${_element.name} class name need to begin with "\$ sign"',
    );

    return _element.name!.substring(1);
  }

  bool _resolveConvertToCamelCase() {
    final convertCase =
        _annotation.peek(AnnotationConfig.convertToCamelCaseField)?.boolValue;
    _throwSourceErrorIf(
      condition: () => convertCase == null,
      message: 'Unexpected error occurred while inspecting '
          '"${AnnotationConfig.convertToCamelCaseField}" in ${_element.name}. '
          'Inspected value equals null.',
    );
    return convertCase!;
  }

  OnBlankValueStrategy _resolveOnBlankValueStrategy() {
    final accessor = _annotation
        .peek(AnnotationConfig.onBlankValueStrategyField)
        ?.revive()
        .accessor;
    _throwSourceErrorIf(
      condition: () => accessor == null,
      message: 'Unexpected error occurred while inspecting '
          '"${AnnotationConfig.onBlankValueStrategyField}" in ${_element.name}.',
    );
    return AnnotationConfig.onBlankValueStrategyStringMap[accessor]!;
  }

  bool _resolveGenerateGetterMethods() {
    final generateGetters = _annotation
        .peek(AnnotationConfig.generateGetterMethodsField)
        ?.boolValue;
    _throwSourceErrorIf(
      condition: () => generateGetters == null,
      message: 'Unexpected error occurred while inspecting '
          '"${AnnotationConfig.generateGetterMethodsField}" in ${_element.name}. '
          'Inspected value equals null.',
    );
    return generateGetters!;
  }

  bool _resolveGenerateOfKeyFactories() {
    final generateOfKeyFactories = _annotation
        .peek(AnnotationConfig.generateOfKeyFactoriesField)
        ?.boolValue;
    _throwSourceErrorIf(
      condition: () => generateOfKeyFactories == null,
      message: 'Unexpected error occurred while inspecting '
          '"${AnnotationConfig.generateOfKeyFactoriesField}" in ${_element.name}. '
          'Inspected value equals null.',
    );
    return generateOfKeyFactories!;
  }

  Future<List<AnnotationConfigLocale>> _resolveLocales() async {
    final locales = _annotation.peek(AnnotationConfig.localesField)?.listValue;
    _throwSourceErrorIf(
      condition: () => locales == null || locales.isEmpty,
      message: "${AnnotationConfig.localesField} list can't be empty",
    );
    return Stream.fromIterable(locales!)
        .asyncMap((object) => _resolveLocale(object))
        .toList();
  }

  Future<AnnotationConfigLocale> _resolveLocale(DartObject object) async {
    final languageCode = object
            .getField(AnnotationConfigLocale.languageCodeField)
            ?.toStringValue() ??
        '';
    final countryCode = object
        .getField(AnnotationConfigLocale.countryCodeField)
        ?.toStringValue();
    final filePath = object
            .getField(AnnotationConfigLocale.translationsFilePathField)
            ?.toStringValue() ??
        '';

    _throwSourceErrorIf(
      condition: () => languageCode.isNullOrBlank || filePath.isNullOrBlank,
      message: '''
    "${AnnotationConfigLocale.languageCodeField}" and "${AnnotationConfigLocale.translationsFilePathField}"
    in auto localized locale declaration can't be null or blank
    ''',
    );

    return AnnotationConfigLocale(
      LocaleInfo(languageCode, countryCode),
      await _assetReader.loadAndDecode(filePath),
    );
  }

  void _throwSourceErrorIf({
    required bool Function() condition,
    required String message,
  }) {
    if (condition()) {
      throw InvalidGenerationSourceError(message, element: _element);
    }
  }
}
