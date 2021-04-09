import 'package:project_kidplanner/src/classes/programStep.dart';

class Program {
  // Eigenschaften
  String programId, title, descr;
  List<ProgramStep> steps;

  // Konstruktor
  Program(this.programId, this.title, this.descr, this.steps);

  @override
  String toString() {
    return this.title;
  }

  String displayDuration() {
    Duration duration = this.getDuration();
    return '${duration.inMinutes}:'
        '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration getDuration() {
    Duration sumDuration = Duration(minutes: 0);
    for (var step in this.steps) {
      sumDuration += step.duration;
    }
    return sumDuration;
  }
}

/// Find a program in the list using firstWhere method.
Program findProgramUsingFirstWhere(List<Program> programs, String programId) {
  final program = programs
      .firstWhere((element) => element.programId == programId, orElse: () {
    return null;
  });
  return program;
}
