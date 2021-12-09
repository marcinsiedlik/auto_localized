class ForbiddenTranslationKeyException implements Exception {
  final String forbiddenKey;
  final String reservedForFeature;

  const ForbiddenTranslationKeyException(
    this.forbiddenKey,
    this.reservedForFeature,
  );

  @override
  String toString() => 'An key: "$forbiddenKey" is forbidden to use '
      'because this is reserved for internal library use, try different name '
      "or disable '$reservedForFeature' feature in config annotation";
}
