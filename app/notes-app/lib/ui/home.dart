import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:notes_app/model/note.dart';
import 'package:notes_app/ui/note_card.dart';

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
      body: _buildNotesOverview(), 
    );
  }

  Widget _buildNotesOverview(){
    Stream<QuerySnapshot> stream = Firestore.instance.collection(user.uid).snapshots();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: new StreamBuilder(
                stream: stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return Center(child: Text('Your notes will appear here.'),);
                  return ListView(
                    children: snapshot.data.documents
                        .map((document) {
                      return NoteCard(
                        note: Note.fromMap(document.data, document.documentID),
                      );
                    }).toList(),
                  );
                },
              ),
          )
        ],
      ),
    );
  }

}
