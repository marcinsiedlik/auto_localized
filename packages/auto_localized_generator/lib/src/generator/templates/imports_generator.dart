import 'code_generator.dart';

class ImportsGenerator implements CodeGenerator {
  static const _imports = [
    'package:auto_localized/auto_localized.dart',
    'package:flutter/cupertino.dart',
    'package:flutter/material.dart',
    'package:flutter_localizations/flutter_localizations.dart',
  ];

  @override
  String generate() {
    final buffer = StringBuffer();
    _imports.forEach((import) {
      buffer.writeln("import '$import';");
    });

    return buffer.toString();
  }
}
