import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/classes/programStep.dart';

import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

class ProgramStepsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Program program =
        ModalRoute.of(context)!.settings.arguments as Program;

    Widget createTile(context, ProgramStep step) {
      return Dismissible(
        direction: DismissDirection.endToStart,
        key: Key(step.id),
        child: Container(
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
        ),
      );
    }

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
          program.steps.length == 0
              ? new SizedBox()
              : ReorderableListView(
                  onReorder: (int start, int current) {
                    print('reorder');
                  },
                  children: [
                    for (var item in program.steps) createTile(context, item)
                  ],
                )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('General_Create').tr(),
        icon: Icon(Icons.keyboard_arrow_right),
        onPressed: () {
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProgramCreateView(),
              settings: RouteSettings(
                arguments: user,
              ),
            ),
          );*/
        },
      ),
    );
  }
}
