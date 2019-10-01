import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/ui/home.dart';
import 'package:notes_app/util/google_auth.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:notes_app/ui/error.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                elevation: 2.0,
                highlightElevation: 2.0,
                disabledElevation: 2.0,
                padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
                color: Colors.grey,
                onPressed: () => {
                  GoogleAuth().handleSignIn().then((FirebaseUser user) {
                    analytics
                        .logEvent(name: 'login', parameters: <String, dynamic>{
                      "method": "google_sign_in",
                    });
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyHomePage(
                                  user: user,
                                )));
                  }).catchError((e) {
                    analytics.logEvent(
                        name: 'login_error',
                        parameters: <String, dynamic>{"error": e});
                    Crashlytics.instance.log("error during login: $e");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ErrorPage(
                                  errorMessage: e.message,
                                )));
                  })
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'images/google.png',
                      height: 40.0,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: new Text(
                          "Sign in with Google",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
