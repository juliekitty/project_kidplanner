import 'package:easy_localization/easy_localization.dart';
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
    builder: (context, dynamic value, child) {
      return Center(
        child: Text(
          globals.currentParticipant.score.toString(),
          style: TextStyle(
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
      (appBarTitle != '' ? appBarTitle : tr('General_appName')),
      style: textTheme.headline6
          .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
    ),
    actions: <Widget>[
      _buildParticipantScore(),
      IconButton(
        icon: Icon(Icons.person),
        tooltip: tr('Profile_PageTitle'),
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
