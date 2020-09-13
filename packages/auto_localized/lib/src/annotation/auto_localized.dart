// ignore_for_file: always_require_non_null_named_parameters

import 'package:auto_localized/src/annotation/auto_localized_locale.dart';
import 'package:auto_localized/src/annotation/on_blank_value_strategy.dart';

///AutoLocalized generator config annotation class
class AutoLocalized {
  ///List of [AutoLocalizedLocale], which is the
  ///main part of the config. List must by not-null and can't be empty.
  final List<AutoLocalizedLocale> locales;

  ///If set to `true` then any key case will be converted to camel case
  ///in generated source. For example json key:
  ///```json
  ///{
  ///  "test_message": "This is a test message in English"
  ///}
  ///```
  ///
  ///will be generated to source:
  ///```dart
  ///static const testMessage = LocalizedString(
  ///    key: 'test_message',
  ///    values: {
  ///     'en_US': '''This is a test message in English''',
  ///     'pl': '''To jest testowa wiadomość w języku Polskim''',
  ///    },
  ///  );
  ///```
  ///
  /// If set to `false` the original key will be used.
  final bool convertToCamelCase;

  ///Defines the behaviour when the value for key is blank
  ///or consists of the characters of whites only.
  ///Blank value will occur in any of the following cases:
  ///
  /// ```json
  ///{
  ///  "blank_value": "",
  ///  "also_blank_value": "   ",
  ///}
  ///```
  ///
  /// This behaviour is will not be triggered if value
  /// is defined as `null`. In that case generator will
  /// always throw an [Exception]
  final OnBlankValueStrategy onBlankValueStrategy;

  /// When set to true apart from fields creates
  /// additional getter methods for generated fields
  /// and extension methods on `BuildContext`.
  /// This gives you the additional ways of getting strings.
  ///
  /// Example:
  /// For given key:
  /// ```json
  /// {
  ///   "test_message": "This is a test message"
  /// }
  /// ```
  /// You can get value with:
  /// ```dart
  /// //field with get
  /// Strings.testMessage.get();
  /// //method getter
  /// Strings.getTestMessage();
  /// //BuildContext extension method
  /// context.getTestMessage();
  /// ```
  ///
  final bool generateGetterMethods;

  const AutoLocalized({
    this.locales,
    this.convertToCamelCase = true,
    this.onBlankValueStrategy = OnBlankValueStrategy.error,
    this.generateGetterMethods = false,
  }) : assert(locales != null);
}
