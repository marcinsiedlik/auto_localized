import 'package:auto_localized_generator/src/model/locale_info.dart';

class LocalizedString {
  final String key;
  Map<LocaleInfo, String> values;

  LocalizedString(this.key, this.values);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalizedString && runtimeType == other.runtimeType && key == other.key && values == other.values;

  @override
  int get hashCode => key.hashCode ^ values.hashCode;

  @override
  String toString() => 'LocalizedString{key: $key, values: $values}';
}
