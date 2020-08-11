import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:auto_localized_generator/src/asset/asset_json_reader.dart';
import 'package:auto_localized_generator/src/config/model/annotation_config.dart';
import 'package:auto_localized_generator/src/config/model/annotation_config_locale.dart';
import 'package:auto_localized_generator/src/model/locale_info.dart';
import 'package:auto_localized_generator/src/utils/string_extensions.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class AnnotationConfigResolver {
  final Element _element;
  final ConstantReader _annotation;
  final AssetJsonReader _assetJsonReader;

  AnnotationConfigResolver(this._element, this._annotation, BuildStep buildStep)
      : _assetJsonReader = AssetJsonReader(buildStep);

  Future<AnnotationConfig> resolve() async {
    final className = _resolveClassName();
    final convertToCamelCase = _resolveConvertToCamelCase();
    final locales = await _resolveLocales();

    return AnnotationConfig(
      className,
      convertToCamelCase,
      locales,
    );
  }

  String _resolveClassName() {
    _throwSourceErrorIf(
      condition: () => _element is! ClassElement,
      message: '${_element.name} is not a class element',
    );
    _throwSourceErrorIf(
      condition: () => !_element.isPrivate,
      message: '${_element.name} is just dummy class for annotation and it should be private',
    );
    _throwSourceErrorIf(
      condition: () => _element.name.substring(0, 2) != '_\$',
      message: '${_element.name} class name need to begin with "_\$ signs"',
    );

    return _element.name.substring(2);
  }

  bool _resolveConvertToCamelCase() {
    final convertCase = _annotation.peek(AnnotationConfig.convertToCamelCaseField)?.boolValue;
    _throwSourceErrorIf(
      condition: () => convertCase == null,
      message: 'Unexpected error occurred while inspecting "convertToCamelCase" in ${_element.name}. '
          'Inspected value equals null.',
    );
    return _annotation.peek(AnnotationConfig.convertToCamelCaseField)?.boolValue;
  }

  Future<List<AnnotationConfigLocale>> _resolveLocales() async {
    final locales = _annotation.peek(AnnotationConfig.localesField)?.listValue;
    _throwSourceErrorIf(
      condition: () => locales == null,
      message: 'Unexpected error occurred while inspecting locales in ${_element.name}. '
          'Inspected value equals null.',
    );
    _throwSourceErrorIf(
      condition: () => locales.isEmpty,
      message: "${AnnotationConfig.localesField} list can't be empty",
    );
    return Stream.fromIterable(locales).asyncMap((object) => _resolveLocale(object)).toList();
  }

  Future<AnnotationConfigLocale> _resolveLocale(DartObject object) async {
    final languageCode = object.getField(AnnotationConfigLocale.languageCodeField)?.toStringValue();
    final countryCode = object.getField(AnnotationConfigLocale.countryCodeField)?.toStringValue();
    final jsonFilePath = object.getField(AnnotationConfigLocale.jsonFilePathField)?.toStringValue();

    _throwSourceErrorIf(
      condition: () => languageCode.isNullOrBlank || jsonFilePath.isNullOrBlank,
      message: '''
    "${AnnotationConfigLocale.languageCodeField}" and "${AnnotationConfigLocale.jsonFilePathField}"
    in auto localized locale declaration cant be null or blank
    ''',
    );

    return AnnotationConfigLocale(
      LocaleInfo(languageCode, countryCode),
      await _assetJsonReader.loadAndDecode(jsonFilePath),
    );
  }

  void _throwSourceErrorIf({bool Function() condition, String message, String todo}) {
    if (condition()) {
      throw InvalidGenerationSourceError(message, element: _element, todo: todo);
    }
  }
}
