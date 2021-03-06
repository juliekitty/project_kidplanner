import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/classes/user.dart';
import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;
import 'package:project_kidplanner/src/libraries/programsData.dart'
    as programsData;
import 'package:project_kidplanner/views/profile/programCreate.dart';
import 'package:project_kidplanner/views/profile/programStepsList.dart';

class ProgramListView extends StatelessWidget {
  const ProgramListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Participant.deleteParticipant(1);

    final Participant user =
        ModalRoute.of(context)!.settings.arguments as Participant;

    final List<Program?>? participantPrograms = user.programs;
    // programsData.programs

    Widget createTile(context, Program /*!*/ program) {
      return Dismissible(
        direction: DismissDirection.endToStart,
        // key: UniqueKey(),
        key: Key(program.programId),
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.fromLTRB(20, 8, 0, 8),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 1, 10, 1),
            child: Text(
              tr('General_DELETE'),
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
          ),
          decoration: const BoxDecoration(color: Colors.red),
        ),
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(tr('Programs_edit.delete_button')),
                content: Text(tr('Programs_edit.delete_confirmation')),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(tr('General_Delete'))),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(tr('General_Cancel')),
                  ),
                ],
              );
            },
          );
        },
        onDismissed: (direction) {
          // Remove the item from the data source.
          Program.remove(participantPrograms, program.programId);

          // Then show a snackbar.
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(tr('Programs_edit.dismissed'))));
        },
        child: Container(
          decoration: globals.profileListBoxDecoration,
          padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
          child: ListTile(
            tileColor: Colors.white,
            //leading: Icon(Icons.star),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text(
              tr(program.title),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right,
                size: Theme.of(context).iconTheme.size,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProgramStepsListView(),
                    settings: RouteSettings(
                      arguments: program.programId,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }

    Widget emptyState() {
      user.programs = programsData.programs;
      Participant.updateParticipant(user);
      return Text('User has no program ${user.toMap()}');
    }

    Widget programList(participantPrograms, context) {
      return ListView(
        scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              tr('Profile_Programs_label'),
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Column(
            children: [
              for (var item in participantPrograms!) createTile(context, item!)
            ],
          )
        ],
      );
    }

    Widget returnBody(participantPrograms, context) {
      if (participantPrograms == null) {
        return emptyState();
      } else {
        return programList(participantPrograms, context);
      }
    }

    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme, 'Program')
          as PreferredSizeWidget?,
      body: returnBody(participantPrograms, context),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('General_Create').tr(),
        icon: const Icon(Icons.keyboard_arrow_right),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProgramCreateView(),
              settings: RouteSettings(
                arguments: user,
              ),
            ),
          );
        },
      ),
    );
  }
}
