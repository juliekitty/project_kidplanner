import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
            step.title.toString(),
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
      appBar: appBar(context, Theme.of(context).textTheme, 'Program'),
      body: ListView(
        scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Earn bonus points with these tasks',
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
