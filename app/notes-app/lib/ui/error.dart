import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget{
  ErrorPage({Key key, this.errorMessage}) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text("An error occoured: $errorMessage"),
    );
  }
  
}