import 'package:build/build.dart';

class JsonFileNotFoundException extends AssetNotFoundException {
  JsonFileNotFoundException(AssetId assetId) : super(assetId);

  @override
  String toString() => 'JsonFileNotFoundException: Unable to find json '
      'file at: ${assetId.path} path. Check if path '
      'is valid. If your JSON file is outside "lib" '
      'folder, check if that folder is added to sources '
      'in build.yaml';
}
