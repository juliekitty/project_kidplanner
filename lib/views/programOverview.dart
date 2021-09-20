import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:time/time.dart';
import 'package:date_time_format/date_time_format.dart';

import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/libraries/programsData.dart';
import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/views/programDetails.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

String timeReady(Program program) {
  DateTime ready = DateTime.now() + program.getDuration();
  return ready.format('H:i'); //ready.format('H:i:s');
}

class ProgramView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? programType =
        ModalRoute.of(context)!.settings.arguments as String?;
//
    //print('ok ${programs.toString()}');
    final Program program = findProgramUsingFirstWhere(programs, programType)!;

    Widget createTile(context, step) {
      return Container(
        decoration: globals.profileListBoxDecoration,
        padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
        child: ListTile(
          tileColor: Colors.white,
          leading: Icon(Icons.star),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text(
            tr('Programs.Steps.' + step.id.toString()),
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          trailing: Text(
            step.displayDuration(),
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      );
    }

    var text = Text(
      tr('Programs.programIntro', namedArgs: {
        'length': program.steps.length.toString(),
        'timeReady': timeReady(program)
      }),
      //'There are ${program.steps.length} steps, you should be ready at ${timeReady(program)}',
      style: Theme.of(context).textTheme.bodyText2,
    );
    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme, 'Program')
          as PreferredSizeWidget?,
      body: ListView(
        scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '${tr('Programs.' + program.programId + '.title')} (${program.displayDuration()})',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              text,
            ]),
          ),
          program.steps.isEmpty
              ? SizedBox()
              : Column(
                  children: [
                    for (var item in program.steps) createTile(context, item)
                  ],
                )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('General_Begin').tr(),
        icon: Icon(Icons.keyboard_arrow_right),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProgramDetailsView(),
              settings: RouteSettings(
                arguments: program.programId,
              ),
            ),
          );
        },
      ),
    );
  }
}
