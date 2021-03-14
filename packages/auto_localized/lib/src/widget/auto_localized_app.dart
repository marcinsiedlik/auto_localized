import 'package:auto_localized/src/localization/auto_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Empty [StatefulWidget] widget that refreshes
///the whole widget tree when [AutoLocalization.locale] value changes.
///[MaterialApp] have to be wrapped with this widget.
class AutoLocalizedApp extends StatefulWidget {
  final Widget child;

  const AutoLocalizedApp({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _AutoLocalizedAppState createState() => _AutoLocalizedAppState();
}

class _AutoLocalizedAppState extends State<AutoLocalizedApp> {
  bool firstLaunch = true;

  @override
  void initState() {
    AutoLocalization.addOnLocaleChangeCallback(_onLocaleChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _onLocaleChange(Locale locale) {
    if (firstLaunch) {
      firstLaunch = false;
      return;
    }
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      (context as Element).visitChildren(_rebuildElement);
    });
  }

  void _rebuildElement(Element element) {
    element.markNeedsBuild();
    element.visitChildren(_rebuildElement);
  }

  @override
  void dispose() {
    AutoLocalization.removeOnLocaleChangeCallback(_onLocaleChange);
    super.dispose();
  }
}
