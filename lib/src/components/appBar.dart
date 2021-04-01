import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_kidplanner/views/profileView.dart';

// defaults
String appBarTitle = '';

//int myPoints = 0;
int myPoints = 1000;

Widget appBar(context, textTheme, appBarTitle) {
  return AppBar(
    title: Text(
      (appBarTitle != '' ? appBarTitle : 'Routine for Kids'),
      style: textTheme.headline6
          .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
    ),
    actions: <Widget>[
      myPoints == 0
          ? new SizedBox()
          : Center(
              child: new Text(
                myPoints.toString(),
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
      IconButton(
        icon: Icon(Icons.person),
        tooltip: 'Profile',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileView()),
          );
        },
      ),
    ],
  );
}
