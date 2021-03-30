import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_kidplanner/views/HomePage.dart';

import 'package:project_kidplanner/views/profileViews.dart';
//import 'package:project_kidplanner/views/CountDownState.dart';
import 'package:project_kidplanner/views/CountDownTimerState.dart';

Widget returnBottomNav(context) {
  return BottomAppBar(
    shape: const CircularNotchedRectangle(),
    color: Colors.amber,
    child: new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
          icon: Icon(
            Icons.home,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        IconButton(
          padding: EdgeInsets.fromLTRB(40, 5, 5, 5),
          icon: Icon(
            Icons.hourglass_bottom,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CountDownTimer()),
            );
          },
        ),
        //
        const Spacer(),
        IconButton(
          padding: EdgeInsets.fromLTRB(5, 5, 40, 5),
          icon: Icon(
            Icons.person,
            size: 30,
          ),
          tooltip: 'Contact',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileView()),
            );
          },
        ),
        IconButton(
          padding: EdgeInsets.fromLTRB(5, 5, 40, 5),
          icon: Icon(
            Icons.list,
            size: 30,
          ),
          tooltip: 'List',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CountDownTimer()),
            );
          },
        ),
      ],
    ),
  );
}
