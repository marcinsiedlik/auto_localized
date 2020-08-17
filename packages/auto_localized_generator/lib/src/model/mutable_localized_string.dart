import 'package:auto_localized_generator/src/model/locale_info.dart';

class MutableLocalizedString {
  final String key;
  Map<LocaleInfo, String> values;

  MutableLocalizedString(this.key, this.values);

  MutableLocalizedString.empty(this.key) : values = {};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MutableLocalizedString && runtimeType == other.runtimeType && key == other.key && values == other.values;

  @override
  int get hashCode => key.hashCode ^ values.hashCode;

  @override
  String toString() => 'MutableLocalizedString{key: $key, values: $values}';
}
