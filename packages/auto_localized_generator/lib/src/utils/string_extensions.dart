extension NullableStringExtensions on String? {
  // bool get isNullOrBlank => this == null || isBlank;
  bool get isNullOrBlank {
    if (this != null) {
      return this!.isBlank;
    }
    return this == null;
  }
}

extension StringExtensions on String {
  bool get isBlank => isEmpty || trim().isEmpty;

  String capitalize() => '${substring(0, 1).toUpperCase()}${substring(1)}';

  bool containsAll(List<Pattern> patterns) {
    for (final pattern in patterns) {
      if (!contains(pattern)) {
        return false;
      }
    }
    return true;
  }
}
