import 'program.dart';

abstract class User {
  String name;

  User(this.name);
}

// Participant
class Participant extends User {
  // programs that the user have access to
  List<Program> programs;
  int score;

  Participant({name, this.programs, this.score}) : super(name);

  int addToScore(int addedPoints) {
    this.score += addedPoints;
    return this.score;
  }
}

// Can manage a participant: a parent for example
class ParticipantManager extends User {
  List<Participant> managedParticipants;

  ParticipantManager(name, this.managedParticipants) : super(name);
}
