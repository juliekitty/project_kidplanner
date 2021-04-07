library project_kidplanner.globals;

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/classes/user.dart';
import 'programsData.dart' as programsData;
import 'package:flutter/material.dart';

// declaration of globals to use as examples in the App
bool isLoggedIn = true;
Participant exampleParticipant = Participant(id: 1, name: 'Mike', score: 10);

ValueNotifier<int> userNotifier = ValueNotifier(currentParticipant.score);

Participant currentParticipant;

List<Program> defaultPrograms = programsData.programs;

const profileListBorders = Border(
  bottom: BorderSide(color: Colors.grey, width: 0.0),
  top: BorderSide(color: Colors.grey, width: 0.0),
  left: BorderSide(color: Colors.grey, width: 0.0),
  right: BorderSide(color: Colors.grey, width: 0.0),
);

const profileListBoxDecoration = BoxDecoration(
  color: Colors.white,
  //borderRadius: BorderRadius.circular(6.0),
  border: profileListBorders,
);
