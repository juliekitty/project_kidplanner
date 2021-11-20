import 'dart:convert';

import 'package:collection/collection.dart';
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
    return title;
  }

  String displayDuration() {
    Duration duration = getDuration();
    return duration.compareTo(const Duration(seconds: 0)) == 0
        ? ''
        : '${duration.inMinutes}:'
            '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration getDuration() {
    Duration sumDuration = const Duration(minutes: 0);
    for (var step in steps) {
      sumDuration += step.duration;
    }
    return sumDuration;
  }

  factory Program.fromRawJson(String str) => Program.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        json["programId"],
        json["title"],
        json["descr"],
        List<ProgramStep>.from(
            json["steps"].map((x) => ProgramStep.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "programId": programId,
        "title": title,
        "descr": descr,
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
      };

  dynamic clone() {
    return Program(programId, title, descr, steps);
  }

  static remove(List<Program?>? programs, String /*!*/ programId) {
    // print('delete it');

    final program = programs!
        .firstWhere((element) => element!.programId == programId, orElse: () {
      return null;
    });
    programs.remove(program);
  }

  removeStep(ProgramStep step) {
    steps.remove(step);
  }

  updateStepDuration(ProgramStep step, Duration newDuration) {
    var index = steps.indexOf(step);
    steps[index].duration = newDuration;
  }

  reorderSteps(int oldIndex, int newIndex, Participant participant) {
    var item = steps[oldIndex];
    steps.insert(newIndex, item);
    steps.removeAt(oldIndex);

    Participant.updateParticipant(participant);
  }
}

/// Find a program in the list using firstWhere method.
Program? findProgramUsingFirstWhere(
    List<Program?> programs, String? programId) {
  final program =
      programs.firstWhereOrNull((element) => element!.programId == programId);

  return program;
}
