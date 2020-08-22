import 'dart:convert';

import 'package:auto_localized_generator/src/exception/file_format_exception.dart';
import 'package:auto_localized_generator/src/exception/json_file_not_found_exception.dart';
import 'package:auto_localized_generator/src/exception/translation_key_value_invalid_exception.dart';
import 'package:build/build.dart';

class AssetJsonReader {
  final BuildStep _buildStep;

  const AssetJsonReader(this._buildStep);

  Future<Map<String, String>> loadAndDecode(String path) async {
    final loaded = await _load(path);
    return _decodeJsonToMap(loaded, path);
  }

  Future<Map<String, String>> _decodeJsonToMap(String stringJson, String path) async {
    try {
      final json = await jsonDecode(stringJson) as Map<String, dynamic>;

      return json.map((key, dynamic value) {
        if (value == null) {
          throw TranslationKeyValueInvalidException(path, key);
        }
        return MapEntry(key, value.toString());
      });
    } on FormatException catch (e) {
      throw FileFormatException(path, e.source, e.offset);
    }
  }

  Future<String> _load(String path) async {
    final assetId = AssetId(_buildStep.inputId.package, path);
    try {
      return await _buildStep.readAsString(assetId);
    } on AssetNotFoundException catch (e) {
      throw JsonFileNotFoundException(e.assetId);
    }
  }
}
