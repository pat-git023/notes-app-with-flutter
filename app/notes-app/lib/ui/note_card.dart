import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/model/note.dart';
import 'package:notes_app/ui/note_edit.dart';

class NoteCard extends StatelessWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final FirebaseUser user;
  final Note note;

  NoteCard(
      {Key key,
      @required this.user,
      @required this.note,
      @required this.analytics,
      @required this.observer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("onTap was called");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EditNote(
                      user: user,
                      note: note,
                    )));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Colors.white38,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  note.text,
                  maxLines: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
