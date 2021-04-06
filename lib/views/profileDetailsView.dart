import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:project_kidplanner/src/classes/user.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

class ProfileDetailsView extends StatefulWidget {
  @override
  _ProfileDetailsViewState createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView> {
  @override
  Widget build(BuildContext context) {
    load();
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[Text('Test page for sqlite')],
    );
  }
}

Future<List<dynamic>> load() async {
  WidgetsFlutterBinding.ensureInitialized();

  var julie = Participant(
    id: 0,
    name: 'Julie',
  );

  // Insert a participant into the database.
  await Participant().insertParticipant(julie);

  // Print the list of participants (only Julie for now).
  print(await Participant().participants());

  // Update Julie's age and save it to the database.
  julie = Participant(
    id: julie.id,
    name: julie.name,
  );
  await Participant().updateParticipant(julie);

  // Print Julie's updated information.
  print(await Participant().participants());

  // Delete Julie from the database.
  await Participant().deleteParticipant(julie.id);

  // Print the list of participants (empty).
  print(await Participant().participants());
}
