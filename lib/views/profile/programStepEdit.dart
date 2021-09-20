import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/classes/programStep.dart';

import 'package:project_kidplanner/src/components/appBar.dart';

class ProgramStepEditView extends StatefulWidget {
  @override
  State<ProgramStepEditView> createState() => _ProgramStepEditViewState();
}

class _ProgramStepEditViewState extends State<ProgramStepEditView> {
  Duration value = Duration();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    final ProgramStep step = args[0];
    final Program program = args[1];

    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme, 'Program')
          as PreferredSizeWidget?,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              step.stepTitle(),
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(tr('ProgramStep_edit.duration_label')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoTimerPicker(
                    initialTimerDuration: step.duration,
                    mode: CupertinoTimerPickerMode.hms,
                    onTimerDurationChanged: (value) {
                      setState(() {
                        this.value = value;
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
                          program.updateStepDuration(step, value);

                          
                        });
                        Navigator.pop(context);

                        Navigator.pop(context);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
