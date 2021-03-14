import 'package:auto_localized_generator/src/model/locale_info.dart';
import 'package:auto_localized_generator/src/model/localized_string_type.dart';

class MutableLocalizedString {
  final String key;
  LocalizedStringType type;
  Map<LocaleInfo, String> values;

  MutableLocalizedString(this.key, this.type, this.values);

  MutableLocalizedString.empty(this.key)
      : values = {},
        type = const PlainLocalizedStringType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MutableLocalizedString &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          type == other.type &&
          values == other.values;

  @override
  int get hashCode => key.hashCode ^ type.hashCode ^ values.hashCode;

  @override
  String toString() => 'MutableLocalizedString{key: $key, values: $values}';
}
