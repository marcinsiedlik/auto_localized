import 'dart:convert';

import 'package:auto_localized_generator/src/exception/file_format_exception.dart';
import 'package:auto_localized_generator/src/exception/json_file_not_found_exception.dart';
import 'package:auto_localized_generator/src/exception/translation_value_invalid_exception.dart';
import 'package:build/build.dart';

class JsonAssetReader {
  final BuildStep _buildStep;

  const JsonAssetReader(this._buildStep);

  Future<Map<String, String>> loadAndDecode(AssetId assetId) async {
    final loaded = await _load(assetId);
    return _decodeJsonToMap(loaded, assetId);
  }

  Future<Map<String, String>> _decodeJsonToMap(String stringJson, AssetId assetId) async {
    try {
      final json = await jsonDecode(stringJson) as Map<String, dynamic>;

      if (json == null) {
        return <String, String>{};
      }
      return json.map((key, dynamic value) {
        if (key == null || value == null) {
          throw TranslationValueInvalidException(
              assetId.path, key, value.toString());
        }
        return MapEntry(key, value.toString());
      });
    } on FormatException catch (e) {
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
