class TranslationKeyValueInvalidException implements Exception {
  final String filePath;
  final String invalidInKey;

  const TranslationKeyValueInvalidException(this.filePath, this.invalidInKey);

  @override
  String toString() => 'Error occurred while parsing file: "$filePath". '
      'value for key "$invalidInKey" is null';
}
