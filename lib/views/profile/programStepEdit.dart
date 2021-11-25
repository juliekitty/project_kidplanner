import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/classes/programStep.dart';
import 'package:project_kidplanner/src/components/appBar.dart';

class ProgramStepEditView extends StatefulWidget {
  const ProgramStepEditView({Key? key}) : super(key: key);

  @override
  State<ProgramStepEditView> createState() => _ProgramStepEditViewState();
}

class _ProgramStepEditViewState extends State<ProgramStepEditView> {
  Duration stepDuration = const Duration();
  String userTitle = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    final ProgramStep step;
    final Program program;
    if (args.length > 0) {
      step = args[0];
      program = args[1];
    } else {
      Navigator.pop(context);
      return const Text('No args found');
    }

    return WillPopScope(
      onWillPop: () async {
        // in the case back button of Appbar is used
        Navigator.pop(context, program);
        return false;
      },
      child: Scaffold(
        appBar: appBar(context, Theme.of(context).textTheme, 'Step Edit')
            as PreferredSizeWidget?,
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Text(
                      tr('ProgramStep_edit.title_label'),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: TextFormField(
                      onChanged: (String? userTitle) {
                        if (userTitle != null) {
                          setState(() {
                            this.userTitle = userTitle;
                          });
                        }
                      },
                      initialValue: step.stepTitle(),
                      validator: (String? value) {
                        return (value == null || value.isEmpty)
                            ? tr('ProgramStep_edit.title_label')
                            : null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      tr('ProgramStep_edit.duration_label'),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: CupertinoTimerPicker(
                      initialTimerDuration: step.duration,
                      mode: CupertinoTimerPickerMode.hms,
                      onTimerDurationChanged: (stepDuration) {
                        setState(() {
                          this.stepDuration = stepDuration;
                        });
                      },
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(tr('General_Saved')),
                            ),
                          );
                          setState(() {
                            if (step.id == '') {
                              step.id = UniqueKey().toString();
                              step.duration = stepDuration;
                              step.userTitle = userTitle;
                              program.addStep(step);
                              Navigator.pop(context, program);
                            } else {
                              step.duration = stepDuration;
                              step.userTitle = userTitle;
                              program.updateStep(step);
                              Navigator.pop(context, program);
                            }
                            // ProgramStep()
                          });
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
