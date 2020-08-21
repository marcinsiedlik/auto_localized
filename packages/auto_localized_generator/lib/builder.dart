import 'package:auto_localized_generator/src/auto_localized_generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder autoLocalized(BuilderOptions options) => LibraryBuilder(
      AutoLocalizedGenerator(),
      generatedExtension: '.al.dart',
      header: '''
        // GENERATED CODE - DO NOT MODIFY BY HAND
        // ignore_for_file: unnecessary_const, constant_identifier_names
      ''',
    );
