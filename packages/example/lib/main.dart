import 'package:example/localization.al.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Localized Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationsDelegates,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate(Strings.welcome),
        ),
      ),
      body: Center(
        child: Text(
          context.translate(Strings.testMessage),
        ),
      ),
    );
  }
}
