import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension AutoLocalizedContextExtension on BuildContext {
  /// An [BuildContext] extension for [LocalizedString.get] method.
  String translate(LocalizedString string) => string.get(this);
}
