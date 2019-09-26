import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/model/note.dart';
import 'package:notes_app/ui/note_edit.dart';

class NoteCard extends StatelessWidget {
  final FirebaseUser user;
  final Note note;

  NoteCard({
    @required this.user,
    @required this.note,
  });

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
    );
  }
}
