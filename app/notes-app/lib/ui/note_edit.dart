import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
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
  bool _isSaveEnabled = false;

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
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
        title: Text(note == null ? 'Add new note' : 'Update the note'),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.delete),
            onPressed: note == null ? null : () => {deleteNote()},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: noteController,
                onChanged: (text) => {
                  if (text.length > 0 && note == null || note.text != text)
                    {
                      setState(() {
                        _isSaveEnabled = true;
                      }),
                    }
                  else
                    {
                      setState(() {
                        _isSaveEnabled = false;
                      }),
                    }
                },
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Enter your text here'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            RaisedButton(
              child: note == null ? Text("Save") : Text("Update"),
              onPressed: _isSaveEnabled ? () => {saveOrUpdateText()} : null,
            ),
          ],
        ),
      ),
    );
  }

  void saveOrUpdateText() async {
    if (note != null) {
      await updateNote();
    } else {
      await saveNote();
    }
  }

  Future saveNote() async {
    await Firestore.instance.collection(user.uid).document().setData({
      'note': base64.encode(utf8.encode(noteController.text)),
      'color': '',
      'creationdate': DateTime.now()
    }).then((v) {
      print("Text saved to DB");
      analytics.logEvent(name: 'note_created', parameters: <String, dynamic>{});
      Navigator.pop(context);
    }).catchError((error) {
      print("Note could not be saved");
      analytics
          .logEvent(name: 'note_create_error', parameters: <String, dynamic>{
        'error': error,
      });
    });
  }

  Future updateNote() async {
    await Firestore.instance.collection(user.uid).document(note.id).updateData(
        {'note': base64.encode(utf8.encode(noteController.text))}).then((v) {
      analytics.logEvent(name: 'note_updated', parameters: <String, dynamic>{});
      Navigator.pop(context);
    }).catchError((error) {
      print('error during update: $error');
      analytics
          .logEvent(name: 'note_updated_error', parameters: <String, dynamic>{
        'error': error,
      });
    });
  }

  void deleteNote() async {
    if (note != null) {
      await Firestore.instance
          .collection(user.uid)
          .document(note.id)
          .delete()
          .then((v) {
        print('Note deleted');
        analytics
            .logEvent(name: 'note_deleted', parameters: <String, dynamic>{});
        Navigator.pop(context);
      }).catchError((error) {
        print('error during delete: $error');
        analytics
            .logEvent(name: 'note_delete_error', parameters: <String, dynamic>{
          'error': error,
        });
      });
    }
  }
}
