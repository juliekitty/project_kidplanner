import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:time/time.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:project_kidplanner/src/libraries/bonusTasksData.dart';

import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

String timeReady(Program program) {
  DateTime ready = DateTime.now() + program.getDuration();
  return ready.format('H:i'); //ready.format('H:i:s');
}

// Because we cannot create
String returnTranslatedStepTitle(BuildContext context, String title) {
  if (title == "Bonus_Task1_title") {
    return tr('Bonus_Task1_title');
  } else if (title == "Bonus_Task2_title") {
    return tr('Bonus_Task2_title');
  } else if (title == "Bonus_Task3_title") {
    return tr('Bonus_Task3_title');
  } else if (title == "Bonus_Task4_title") {
    return tr('Bonus_Task4_title');
  } else if (title == "Bonus_Task5_title") {
    return tr('Bonus_Task5_title');
  } else if (title == "Bonus_Task6_title") {
    return tr('Bonus_Task6_title');
  } else if (title == "Bonus_Task7_title") {
    return tr('Bonus_Task7_title');
  }
  return tr('Bonus_PageTitle');
}

class BonusTasksView extends StatefulWidget {
  @override
  _BonusTasksViewState createState() => _BonusTasksViewState();
}

class _BonusTasksViewState extends State<BonusTasksView> {
  @override
  Widget build(BuildContext context) {
    Widget createTile(context, step) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
        child: ListTile(
          tileColor: (step.done ? Colors.amber[100] : Colors.amber),
          hoverColor: Colors.amber[200],
          mouseCursor: MaterialStateMouseCursor.clickable,
          enabled: (step.done ? false : true),
          leading: (step.done
              ? Icon(Icons.check_box)
              : Icon(Icons.check_box_outline_blank)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text(
            returnTranslatedStepTitle(context, step.id.toString()),
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline6,
          ),
          trailing: Text(
            step.points.toString(),
            style: Theme.of(context).textTheme.headline6,
          ),
          onTap: () {
            if (!step.done) {
              globals.currentParticipant.addToScore(step.points);
              setState(() {
                step.done = true;
              });
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme, 'Bonus'),
      body: ListView(
        scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              tr('Bonus_PageIntroText'),
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          bonusTasks.length == 0
              ? new SizedBox()
              : Column(
                  children: [
                    for (var item in bonusTasks) createTile(context, item)
                  ],
                ),
        ],
      ),
    );
  }
}
