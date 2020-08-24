import 'package:auto_localized_generator/src/asset/asset_reader.dart';

class FileExtensionNotSupported implements Exception {
  final String path;

  const FileExtensionNotSupported(this.path);

  @override
  String toString() => 'File "$path" have unsupported extension. '
      'Supported file types: ${AssetReader.supportedExtensions}';
}
