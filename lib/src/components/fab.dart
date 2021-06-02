import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_kidplanner/views/bonusTasksView.dart';

Widget returnFab(context) {
  return FloatingActionButton(
    tooltip: tr('HP_Carousel_Bonus_TasksDescr'),
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
