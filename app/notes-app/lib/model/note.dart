import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class Note {
  final String id;
  final String text;
  final Timestamp creationDate;
  final String color;

  const Note({
    this.id,
    this.text,
    this.creationDate,
    this.color,
  });

  Note.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          text: utf8.decode(base64.decode(data['note'])),
          creationDate: data['creationdate'],
          color: data['Color'],
        );
}