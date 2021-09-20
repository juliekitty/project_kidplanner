import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/classes/user.dart';

import 'package:project_kidplanner/src/components/appBar.dart';

class ProgramCreateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Participant user =
        ModalRoute.of(context)!.settings.arguments as Participant;

    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme, 'Program')
          as PreferredSizeWidget?,
      body: Container(),
    );
  }
}
