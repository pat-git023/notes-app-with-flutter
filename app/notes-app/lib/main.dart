import 'package:flutter/material.dart';
import 'ui/login.dart';
import 'ui/home.dart';
import 'ui/splash.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() {
  Crashlytics.instance.enableInDevMode = false;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  Crashlytics.instance.setUserEmail("patgit023@gmail.com");
  Crashlytics.instance.setUserIdentifier("4711");
  Crashlytics.instance.setUserName("Pat");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => MyHomePage(),
        '/login': (BuildContext context) => LoginPage(
              analytics: analytics,
              observer: observer,
            ),
      },
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}
