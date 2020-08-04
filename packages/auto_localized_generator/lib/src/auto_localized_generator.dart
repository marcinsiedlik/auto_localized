import 'package:analyzer/dart/element/element.dart';
import 'package:auto_localized/annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class AutoLocalizedGenerator extends GeneratorForAnnotation<AutoLocalized> {
  @override
  Future generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    // TODO: implement generateForAnnotatedElement
    throw UnimplementedError();
  }
}
