import 'package:project_kidplanner/src/classes/programStep.dart';
import 'package:project_kidplanner/src/classes/user.dart';

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

  static remove(List<Program?>? programs, String /*!*/ programId) {
    print('delete it');

    final program = programs!
        .firstWhere((element) => element!.programId == programId, orElse: () {
      return null;
    });
    programs.remove(program);
  }

  removeStep(ProgramStep step) {
    this.steps.remove(step);
  }

  updateStepDuration(ProgramStep step, Duration newDuration) {
    var index = this.steps.indexOf(step);
    this.steps[index].duration = newDuration;
  }

  reorderSteps(int oldIndex, int newIndex, Participant participant) {
    var item = this.steps[oldIndex];
    this.steps.insert(newIndex, item);
    this.steps.removeAt(oldIndex);

    Participant.updateParticipant(participant);
  }

  fromJson(Map<String, dynamic> json) {
    print('fromJson');
    return {
      programId = json['programId'],
      title = json['title'],
      //steps = json['steps'],
      descr = json['descr'],
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'programId': programId,
      'title': title,
      //'steps': steps,
      'descr': descr,
    };
  }
}

/// Find a program in the list using firstWhere method.
Program? findProgramUsingFirstWhere(
    List<Program?> programs, String? programId) {
  final program = programs
      .firstWhere((element) => element!.programId == programId, orElse: () {
    return null;
  });
  return program;
}
