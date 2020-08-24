import 'package:auto_localized/annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'auto_localized_generator.dart';

///Builder definition for [AutoLocalized] annotation.
///Generates standalone dart file with `.al.dart` extension.
Builder autoLocalized(BuilderOptions options) => LibraryBuilder(
      AutoLocalizedGenerator(),
      generatedExtension: '.al.dart',
      header: '''
        // GENERATED CODE - DO NOT MODIFY BY HAND
        // ignore_for_file: unnecessary_const, constant_identifier_names
      ''',
    );
