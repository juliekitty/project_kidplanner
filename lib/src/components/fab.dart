import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../views/bonusTasksView.dart';

Widget returnFab(context) {
  return FloatingActionButton(
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
