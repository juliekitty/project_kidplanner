library project_kidplanner.globals;

import 'package:project_kidplanner/src/classes/user.dart';
import 'programsData.dart' as programsData;

// declaration of globals to use as examples in the App
bool isLoggedIn = true;
Participant exampleParticipant =
    Participant(name: 'Mike', programs: programsData.programs, score: 10000);
