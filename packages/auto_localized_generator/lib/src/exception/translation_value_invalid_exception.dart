class TranslationValueInvalidException implements Exception {
  final String filePath;
  final String? key;
  final String value;

  const TranslationValueInvalidException(this.filePath, this.key, this.value);

  @override
  String toString() => 'Error occurred while parsing file: "$filePath". '
      'Invalid translation:: key: "${key ?? 'null'}", value: "$value".';
}
