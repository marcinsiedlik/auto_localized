extension StringExtensions on String {
  bool get isNullOrBlank => isNull || isBlank;

  bool get isNull => this == null;

  bool get isBlank => isEmpty || trim().isEmpty;

  String capitalize() => '${substring(0, 1).toUpperCase()}${substring(1)}';
}
