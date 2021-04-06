import 'package:project_kidplanner/src/classes/user.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

class Init {
  static Future initialize() async {
    await _registerServices();
    await _loadSettings();
  }

  static _registerServices() async {
    print("starting registering services");
    await Future.delayed(Duration(seconds: 1));
    print("finished registering services");
  }

  static _loadSettings() async {
    print("starting loading settings");
    // TODO retrieve last logged-in user from local storage
    // load settings from current user
    await Future.delayed(Duration(seconds: 1));
    globals.currentParticipant = await Participant().getParticipant(1);

    print("finished loading settings");
  }
}
