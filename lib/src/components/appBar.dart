import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_kidplanner/views/profileView.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

// defaults
String appBarTitle = '';

// need ValueListenableBuilder to update the score of Participan when changed
Widget _buildParticipantScore() {
  return ValueListenableBuilder(
    valueListenable: globals.userNotifier,
    builder: (context, value, child) {
      return Center(
        child: new Text(
          globals.currentParticipant.score.toString(),
          style: new TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    },
  );
}

Widget appBar(context, textTheme, appBarTitle) {
  return AppBar(
    title: Text(
      (appBarTitle != '' ? appBarTitle : 'Routine for Kids'),
      style: textTheme.headline6
          .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
    ),
    actions: <Widget>[
      globals.exampleParticipant.score == 0
          ? new SizedBox()
          : _buildParticipantScore(),
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
