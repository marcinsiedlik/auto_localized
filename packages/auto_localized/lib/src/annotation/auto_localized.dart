// ignore_for_file: always_require_non_null_named_parameters

import 'package:auto_localized/src/annotation/auto_localized_locale.dart';

class AutoLocalized {
  final List<AutoLocalizedLocale> locales;
  final bool convertToCamelCase;

  const AutoLocalized({
    this.locales,
    this.convertToCamelCase = false,
  }) : assert(locales != null);
}
