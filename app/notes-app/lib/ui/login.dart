import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/ui/home.dart';
import 'package:notes_app/util/google_auth.dart';

class LoginPage extends StatelessWidget {
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
                  GoogleAuth()
                      .handleSignIn()
                      .then((FirebaseUser user) => {
                            print(user),
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MyHomePage(
                                          user: user,
                                        )))
                          })
                      .catchError((e) => print(e))
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
