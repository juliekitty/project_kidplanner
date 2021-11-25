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
        key: UniqueKey(),
        child: Card(
          key: UniqueKey(),
          child: Column(
            children: <Widget>[
              ListTile(
                tileColor: Colors.white,
                leading: const Icon(Icons.drag_handle_rounded),
                title: Text(
                  step.stepTitle(),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                subtitle: Text(
                  step.displayDuration(),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                trailing: TextButton(
                  child: Text(tr('General_Edit')),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProgramStepEditView(),
                        settings: RouteSettings(
                          arguments: [step, program],
                        ),
                      ),
                    );
                    setState(() {
                      if (result != null) program = result;
                    });
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
            program!.removeStep(step);
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

    if (program == null) {
      return const Text('No program found');
    }

    return WillPopScope(
        onWillPop: () async {
          // in the case back button of Appbar is used
          Navigator.pop(context, program!.steps);
          return false;
        },
        child: Scaffold(
          appBar: appBar(context, Theme.of(context).textTheme, 'Steps List')
              as PreferredSizeWidget?,
          body: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            key: UniqueKey(),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 250),
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '${tr('Programs.' + program!.programId + '.title')} (${program!.displayDuration()})',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              program!.steps.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 250),
                      child: ReorderableListView(
                        buildDefaultDragHandles: true,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        //physics: ScrollPhysics(),
                        onReorder: (int start, int current) {
                          setState(() {
                            program!.reorderSteps(
                                start, current, globals.currentParticipant);
                          });
                        },
                        children: <Widget>[
                          for (var item in program!.steps)
                            createCard(context, item),
                        ],
                      ),
                    ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text('General_Create').tr(),
            icon: const Icon(Icons.keyboard_arrow_right),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProgramStepEditView(),
                  settings: RouteSettings(
                    arguments: [ProgramStep(), program],
                  ),
                ),
              );
              setState(() {
                if (result != null) program = result;
              });
            },
          ),
        ));
  }
}
