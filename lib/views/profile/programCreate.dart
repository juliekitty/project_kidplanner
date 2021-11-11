import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/components/appBar.dart';

class ProgramCreateView extends StatelessWidget {
  const ProgramCreateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Participant user = ModalRoute.of(context)!.settings.arguments as Participant;

    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme, 'Program')
          as PreferredSizeWidget?,
      body: Container(),
    );
  }
}
