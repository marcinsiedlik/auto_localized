import 'dart:async';

import 'package:auto_localized_generator/src/asset/json_asset_reader.dart';
import 'package:auto_localized_generator/src/asset/yaml_asset_reader.dart';
import 'package:auto_localized_generator/src/exception/file_extension_not_supported_exception.dart';
import 'package:auto_localized_generator/src/exception/key_duplicate_found_exception.dart';
import 'package:auto_localized_generator/src/utils/list_extensions.dart';
import 'package:build/build.dart';

class AssetReader {
  final BuildStep _buildStep;

  final JsonAssetReader _jsonReader;
  final YamlAssetReader _yamlReader;

  AssetReader(this._buildStep)
      : _jsonReader = JsonAssetReader(_buildStep),
        _yamlReader = YamlAssetReader(_buildStep);

  Future<Map<String, String>> loadAndDecode(String path) async {
    final assetId = AssetId(_buildStep.inputId.package, path);

    return _onExtension(
      extension: assetId.extension,
      json: () => _jsonReader.loadAndDecode(assetId),
      yaml: () => _yamlReader.loadAndDecode(assetId),
      notSupported: () => throw FileExtensionNotSupported(assetId.path),
    );
  }

  Future<Map<String, String>> loadAndDecodeList(
    List<String> paths,
    String locale,
  ) async {
    final maps =
        await Stream.fromIterable(paths).asyncMap(loadAndDecode).toList();

    _assertNoDuplicates(maps, locale);

    return Map.fromEntries(maps.expand((element) => element.entries));
  }

  void _assertNoDuplicates(List<Map<String, String>> maps, String locale) {
    final allKeys = maps.expand((map) => map.keys).toList();
    final duplicates = allKeys.duplicates;

    if (duplicates.isNotEmpty) {
      throw KeyDuplicateFoundException(locale, duplicates);
    }
  }

  R _onExtension<R>({
    required String extension,
    required R Function() json,
    required R Function() yaml,
    required R Function() notSupported,
  }) {
    if (extension == '.json') {
      return json();
    } else if (extension == '.yaml') {
      return yaml();
    } else {
      return notSupported();
    }
  }

  static const supportedExtensions = 'JSON, YAML';
}
