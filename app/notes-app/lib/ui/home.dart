import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.user}) : super(key: key);

  final String title = 'Notes App';
  final FirebaseUser user;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      user = widget.user;
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
          children: <Widget>[
            Text("Notes App"),
            Text("User: " + user.displayName),
          ],
        ), 
    );
  }

}
