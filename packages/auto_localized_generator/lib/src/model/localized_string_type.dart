abstract class LocalizedStringType {
  final int id;
  final String name;
  final String getterParams;
  final String getterContextExtensionParams;
  final String getterArgs;
  final String getterContextExtensionArgs;

  const LocalizedStringType(
    this.id,
    this.name,
    this.getterParams,
    this.getterContextExtensionParams,
    this.getterArgs,
    this.getterContextExtensionArgs,
  );

  factory LocalizedStringType.resolveFromValue(String value) {
    if (value.contains(_arg5)) return const ArgLocalizedStringType5();
    if (value.contains(_arg4)) return const ArgLocalizedStringType4();
    if (value.contains(_arg3)) return const ArgLocalizedStringType3();
    if (value.contains(_arg2)) return const ArgLocalizedStringType2();
    if (value.contains(_arg1)) return const ArgLocalizedStringType1();
    return const PlainLocalizedStringType();
  }

  factory LocalizedStringType.resolveFromValues(Iterable<String> values) =>
      values
          .map((e) => LocalizedStringType.resolveFromValue(e))
          .reduce((value, element) => value = value.getHigher(element));

  LocalizedStringType getHigher(LocalizedStringType other) =>
      id >= other.id ? this : other;

  T when<T>({
    required T Function(PlainLocalizedStringType) plain,
    required T Function(ArgLocalizedStringType1) arg1,
    required T Function(ArgLocalizedStringType2) arg2,
    required T Function(ArgLocalizedStringType3) arg3,
    required T Function(ArgLocalizedStringType4) arg4,
    required T Function(ArgLocalizedStringType5) arg5,
  }) {
    if (this is PlainLocalizedStringType) {
      return plain(this as PlainLocalizedStringType);
    } else if (this is ArgLocalizedStringType1) {
      return arg1(this as ArgLocalizedStringType1);
    } else if (this is ArgLocalizedStringType2) {
      return arg2(this as ArgLocalizedStringType2);
    } else if (this is ArgLocalizedStringType3) {
      return arg3(this as ArgLocalizedStringType3);
    } else if (this is ArgLocalizedStringType4) {
      return arg4(this as ArgLocalizedStringType4);
    } else {
      return arg5(this as ArgLocalizedStringType5);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalizedStringType &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  static const _arg1 = '{1}';
  static const _arg2 = '{2}';
  static const _arg3 = '{3}';
  static const _arg4 = '{4}';
  static const _arg5 = '{5}';
}

class PlainLocalizedStringType extends LocalizedStringType {
  const PlainLocalizedStringType()
      : super(
    0,
          'PlainLocalizedString',
          '([BuildContext? context])',
          '()',
          '(context)',
          '(this)',
        );
}

class ArgLocalizedStringType1 extends LocalizedStringType {
  const ArgLocalizedStringType1()
      : super(
    1,
          'ArgLocalizedString1',
          '(String arg, [BuildContext? context])',
          '(String arg)',
          '(arg, context)',
          '(arg, this)',
        );
}

class ArgLocalizedStringType2 extends LocalizedStringType {
  const ArgLocalizedStringType2()
      : super(
    2,
          'ArgLocalizedString2',
          '(String arg1, String arg2, [BuildContext? context,])',
          '(String arg1, String arg2)',
          '(arg1, arg2, context)',
          '(arg1, arg2, this)',
        );
}

class ArgLocalizedStringType3 extends LocalizedStringType {
  const ArgLocalizedStringType3()
      : super(
    3,
          'ArgLocalizedString3',
          '(String arg1, String arg2, String arg3, [BuildContext? context,])',
          '(String arg1, String arg2, String arg3,)',
          '(arg1, arg2, arg3, context)',
          '(arg1, arg2, arg3, this)',
        );
}

class ArgLocalizedStringType4 extends LocalizedStringType {
  const ArgLocalizedStringType4()
      : super(
    4,
          'ArgLocalizedString4',
          '(String arg1, String arg2, String arg3, String arg4, [BuildContext? context,])',
          '(String arg1, String arg2, String arg3, String arg4,)',
          '(arg1, arg2, arg3, arg4, context)',
          '(arg1, arg2, arg3, arg4, this)',
        );
}

class ArgLocalizedStringType5 extends LocalizedStringType {
  const ArgLocalizedStringType5()
      : super(
    5,
          'ArgLocalizedString5',
          '(String arg1, String arg2, String arg3, String arg4, String arg5, [BuildContext? context,])',
          '(String arg1, String arg2, String arg3, String arg4, String arg5,)',
          '(arg1, arg2, arg3, arg4, arg5, context)',
          '(arg1, arg2, arg3, arg4, arg5, this)',
        );
}
