class LocaleInfo {
  final String languageCode;
  final String? countryCode;

  const LocaleInfo(this.languageCode, this.countryCode);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocaleInfo &&
          runtimeType == other.runtimeType &&
          languageCode == other.languageCode &&
          countryCode == other.countryCode;

  @override
  int get hashCode => languageCode.hashCode ^ countryCode.hashCode;

  @override
  String toString() =>
      languageCode + (countryCode != null ? '_$countryCode' : '');
}
