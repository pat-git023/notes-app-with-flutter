import 'package:flutter/material.dart';

import 'package:notes_app/model/note.dart';


class NoteCard extends StatelessWidget {
  final Note note;

  NoteCard(
      {@required this.note,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => (){},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(note.text)
            ],
          ),
        ),
      ),
    );
  }
}