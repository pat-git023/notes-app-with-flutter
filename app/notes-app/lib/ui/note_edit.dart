import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'package:notes_app/model/note.dart';

class EditNote extends StatefulWidget {
  EditNote({Key key, this.user, this.note}) : super(key: key);

  final FirebaseUser user;
  final Note note;

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final TextEditingController noteController = TextEditingController();

  FirebaseUser user;
  Note note;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      user = widget.user;
      note = widget.note;
      if (note != null) {
        setState(() {
          noteController.text = note.text;
        });
      }
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new notes'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: noteController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter your note'),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          RaisedButton(
            color: Colors.grey,
            child: note == null ? Text("Save") : Text("Update"),
            onPressed: () => {saveOrUpdateText()},
          ),
        ],
      ),
    );
  }

  void saveOrUpdateText() async {
    if (note != null) {
      await Firestore.instance
          .collection(user.uid)
          .document(note.id)
          .updateData({
        'note': base64.encode(utf8.encode(noteController.text))
      }).then((v) {
        print('Note updated');
        Navigator.pop(context);
      }).catchError((error) {
        print('error during update: $error');
      });
    } else {
      await Firestore.instance.collection(user.uid).document().setData({
        'note': base64.encode(utf8.encode(noteController.text)),
        'color': '',
        'creationdate': DateTime.now()
      }).then((v) {
        print("Text saved to DB");
        Navigator.pop(context);
      }).catchError((error) {
        print("Note could not be saved");
      });
    }
  }
}
