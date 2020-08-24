import 'package:auto_localized_generator/src/exception/file_format_exception.dart';
import 'package:auto_localized_generator/src/exception/json_file_not_found_exception.dart';
import 'package:auto_localized_generator/src/exception/translation_value_invalid_exception.dart';
import 'package:build/build.dart';
import 'package:yaml/yaml.dart';

class YamlAssetReader {
  final BuildStep _buildStep;

  const YamlAssetReader(this._buildStep);

  Future<Map<String, String>> loadAndDecode(AssetId assetId) async {
    final loaded = await _load(assetId);
    return _decodeYamlToMap(loaded, assetId);
  }

  Future<Map<String, String>> _decodeYamlToMap(String yamlString, AssetId assetId) async {
    try {
      final yaml = await loadYaml(yamlString) as YamlMap;

      return yaml.map((dynamic key, dynamic value) {
        if (key == null || value == null) {
          throw TranslationValueInvalidException(assetId.path, key.toString(), value.toString());
        }
        return MapEntry(key.toString(), value.toString());
      });
    } on YamlException catch (e) {
      throw FileFormatException(assetId.path, e.source, e.offset);
    }
  }

  Future<String> _load(AssetId assetId) async {
    try {
      return await _buildStep.readAsString(assetId);
    } on AssetNotFoundException catch (e) {
      throw FileNotFoundException(e.assetId);
    }
  }
}
