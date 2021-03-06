import 'package:date_time_format/date_time_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/libraries/bonusTasksData.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;
import 'package:time/time.dart';

String timeReady(Program program) {
  DateTime ready = DateTime.now() + program.getDuration();
  return ready.format('H:i'); //ready.format('H:i:s');
}

class BonusTasksView extends StatefulWidget {
  const BonusTasksView({Key? key}) : super(key: key);

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
              ? const Icon(Icons.check_box)
              : const Icon(Icons.check_box_outline_blank)),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text(
            tr('Bonus_' + step.id.toString() + '_title'),
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          trailing: Text(
            step.points.toString(),
            style: Theme.of(context).textTheme.bodyText2,
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
      appBar:
          appBar(context, Theme.of(context).textTheme, tr('Bonus_PageTitle'))
              as PreferredSizeWidget?,
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
          bonusTasks.isEmpty
              ? const SizedBox()
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
