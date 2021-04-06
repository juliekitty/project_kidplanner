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
