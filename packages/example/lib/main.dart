import 'package:auto_localized/auto_localized.dart';
import 'package:example/localization.al.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoLocalizedApp(
      child: MaterialApp(
        title: 'Auto Localized Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationsDelegates,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.welcomeName.get('Marcin', ':D'),
        ),
      ),
      body: Center(
        child: Text(
          Strings.getTestMessage(),
        ),
      ),
    );
  }
}
