import 'package:auto_localized_generator/src/model/locale_info.dart';
import 'package:auto_localized_generator/src/model/localized_string_type.dart';
import 'package:auto_localized_generator/src/model/mutable_localized_string.dart';

class LocalizedString {
  final String key;
  final LocalizedStringType type;
  final Map<LocaleInfo, String> values;

  const LocalizedString(this.key, this.type, this.values);

  factory LocalizedString.fromMutable(MutableLocalizedString mutable) => LocalizedString(
        mutable.key,
        mutable.type,
        Map.unmodifiable(mutable.values),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LocalizedString &&
              runtimeType == other.runtimeType &&
              key == other.key &&
              type == other.type &&
              values == other.values;

  @override
  int get hashCode => key.hashCode ^ type.hashCode ^ values.hashCode;

  @override
  String toString() => 'LocalizedString{key: $key, values: $values}';
}
