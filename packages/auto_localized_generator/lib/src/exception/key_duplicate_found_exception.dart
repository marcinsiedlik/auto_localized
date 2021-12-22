class KeyDuplicateFoundException implements Exception {
  final String locale;
  final List<String> keys;

  const KeyDuplicateFoundException(this.locale, this.keys);

  @override
  String toString() => 'Error occurred while parsing translation keys '
      'for locale $locale. Found duplicate for keys: ${keys.join(', ')}';
}
