import 'package:build/build.dart';

class FileNotFoundException extends AssetNotFoundException {
  FileNotFoundException(AssetId assetId) : super(assetId);

  @override
  String toString() => 'FileNotFoundException: Unable to find translations '
      'file at: ${assetId.path} path. Check if path '
      'is valid. If your file is outside "lib" '
      'folder, check if that folder is added to sources '
      'in build.yaml. Also path must be relative';
}
