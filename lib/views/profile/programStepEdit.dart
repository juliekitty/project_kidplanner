import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/classes/programStep.dart';

import 'package:project_kidplanner/src/components/appBar.dart';

class ProgramStepEditView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProgramStep step =
        ModalRoute.of(context)!.settings.arguments as ProgramStep;

    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme, 'Program')
          as PreferredSizeWidget?,
      body: Container(
        child: Text('Edit ${step.id}'),
      ),
    );
  }
}
