import 'dart:io';

class Logger {
  static const _separator = "*******************************************************************************";
  static const _generatorHeader = 'LocalizationsGenerator::';

  static void debug(String message, {bool withSeparator = true}) {
    _message('[DEBUG]', message, withSeparator);
  }

  static void info(String message, {bool withSeparator = true}) {
    _message('[INFO]', message, withSeparator);
  }

  static void warning(String message, {bool withSeparator = true}) {
    _message('[WARNING]', message, withSeparator);
  }

  static void error(String message, {bool withSeparator = true}) {
    _message('[ERROR]', message, withSeparator);
  }

  static void _message(String typeHeader, String message, bool withSeparator) {
    final outMessages = withSeparator
        ? [
            _separator,
            '$typeHeader $_generatorHeader $message',
            _separator,
          ]
        : [message];

    outMessages.forEach(stdout.writeln);
  }
}
