import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/classes/programStep.dart';
import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;
import 'package:project_kidplanner/views/profile/programStepEdit.dart';

class ProgramStepsListView extends StatefulWidget {
  const ProgramStepsListView({Key? key}) : super(key: key);

  @override
  ProgramStepsListViewState createState() => ProgramStepsListViewState();
}

class ProgramStepsListViewState extends State<ProgramStepsListView> {
  @override
  Widget build(BuildContext context) {
    final programID = ModalRoute.of(context)!.settings.arguments;

    Program? program = findProgramUsingFirstWhere(
        globals.currentParticipant.programs!, programID.toString());

    Widget createCard(context, ProgramStep step) {
      return Dismissible(
        direction: DismissDirection.endToStart,
        key: Key(step.id),
        child: Card(
          key: Key(step.id),
          child: Column(
            children: <Widget>[
              ListTile(
                tileColor: Colors.white,
                leading: const Icon(Icons.drag_handle_rounded),
                title: Text(
                  tr('Programs.Steps.' + step.id.toString()),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                subtitle: Text(
                  step.displayDuration(),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                trailing: TextButton(
                  child: Text(tr('General_Edit')),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProgramStepEditView(),
                        settings: RouteSettings(
                          arguments: [step, program],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
                title: Text(tr('ProgramStep_edit.delete_button')),
                content: Text(tr('ProgramStep_edit.delete_confirmation')),
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
          if (program != null) {
            program.removeStep(step);
          }
          setState(() {
            program!.steps.remove(step);
          });
          // Then show a snackbar.
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(tr('ProgramStep_edit.dismissed'))));
        },
      );
    }
/*
    Widget createTile(context, ProgramStep step) {
      return Dismissible(
        direction: DismissDirection.endToStart,
        key: Key(step.id),
        child: Container(
          constraints: carouselConstraints,
          decoration: globals.profileListBoxDecoration,
          padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
          child: ListTile(
            tileColor: Colors.white,
            trailing: Icon(Icons.drag_handle_rounded),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text(
              tr('Programs.Steps.' + step.id.toString()),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            leading: Icon(Icons.star),
            /*leading: Text(
              step.displayDuration(),
              style: Theme.of(context).textTheme.bodyText2,
            ),*/
          ),
        ),
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(20, 8, 0, 8),
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
          decoration: BoxDecoration(color: Colors.red),
        ),
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(tr('ProgramStep_edit.delete_button')),
                content: Text(tr('ProgramStep_edit.delete_confirmation')),
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
          // Program.delete(participantPrograms, program.programId);

          // Then show a snackbar.
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(tr('ProgramStep_edit.dismissed'))));
        },
      );
    }

    */

    if (program == null) {
      return const Text('No program found');
    }

    return WillPopScope(
        onWillPop: () async {
          // in the case back button of Appbar is used
          Navigator.pop(context, program.steps);
          return false;
        },
        child: Scaffold(
          appBar: appBar(context, Theme.of(context).textTheme, 'Steps List')
              as PreferredSizeWidget?,
          body: Column(
            //scrollDirection: Axis.vertical,
            //shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '${tr('Programs.' + program.programId + '.title')} (${program.displayDuration()})',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              program.steps.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      child: ReorderableListView(
                        buildDefaultDragHandles: true,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        //physics: ScrollPhysics(),
                        onReorder: (int start, int current) {
                          setState(() {
                            program.reorderSteps(
                                start, current, globals.currentParticipant);
                          });
                        },
                        children: <Widget>[
                          for (var item in program.steps)
                            createCard(context, item),
                        ],
                      ),
                    ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, program.steps);
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
          /*floatingActionButton: FloatingActionButton.extended(
            label: const Text('General_Create').tr(),
            icon: const Icon(Icons.keyboard_arrow_right),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProgramStepEditView(),
                  settings: RouteSettings(
                    arguments: [program, ProgramStep()],
                  ),
                ),
              );
            },
          ),
          */
        ));
  }
}
