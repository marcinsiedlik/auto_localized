// ignore_for_file: always_require_non_null_named_parameters

import 'package:auto_localized/src/annotation/auto_localized_locale.dart';
import 'package:auto_localized/src/annotation/on_blank_value_strategy.dart';

class AutoLocalized {
  final List<AutoLocalizedLocale> locales;
  final bool convertToCamelCase;
  final OnBlankValueStrategy onBlankValueStrategy;

  const AutoLocalized({
    this.locales,
    this.convertToCamelCase = false,
    this.onBlankValueStrategy = OnBlankValueStrategy.error,
  }) : assert(locales != null);
}
