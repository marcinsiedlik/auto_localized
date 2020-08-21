import 'code_generator.dart';

class ImportsGenerator implements CodeGenerator {
  static const _imports = [
    'package:flutter/cupertino.dart',
    'package:flutter/material.dart',
    'package:auto_localized/auto_localized.dart',
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
