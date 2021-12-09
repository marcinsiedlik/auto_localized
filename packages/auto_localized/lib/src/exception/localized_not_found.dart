class LocalizedStringNotFoundException implements Exception {
  final String missingKey;

  const LocalizedStringNotFoundException(this.missingKey);

  @override
  String toString() => 'Error occurred while while trying to find '
      'LocalizedString of original key: $missingKey. Remember to use original '
      'key from translation file instead of property name';
}
