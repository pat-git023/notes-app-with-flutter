import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget buildBurgerMenu(FirebaseUser user) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new CachedNetworkImageProvider(user.photoUrl),
                  ),
                ),
              ),
              SizedBox(width: 15,),
              Text(user.displayName),
            ],
          ),
          decoration: BoxDecoration(color: Colors.blue),
        ),
        SizedBox(height: 150),
        Text('Logout'),
      ],
    ),
  );
}
