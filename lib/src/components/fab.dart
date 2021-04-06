import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_kidplanner/views/bonusTasksView.dart';

Widget returnFab(context) {
  return FloatingActionButton(
    tooltip: 'Win bonus points',
    child: Icon(
      Icons.star,
      color: Colors.white,
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BonusTasksView()),
      );
    },
  );
}
