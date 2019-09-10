import 'package:flutter/material.dart';
import 'ui/login.dart';
import 'ui/home.dart';
import 'ui/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => MyHomePage(),
        '/login': (BuildContext context) => LoginPage(),
      },
    );
  }
}

