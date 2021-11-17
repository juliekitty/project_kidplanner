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

  static Program jsonDecodeProgram(json) {
    return Program(
      json["programId"],
      json["title"],
      json["descr"],
      json["steps"] ?? [], // use empty array temporary
    );
  }

/* 
Output a json encoded Program 
*/
  static String jsonEncodeProgram(program) {
    Map<String, dynamic> programCopy = {
      "programId": program.programId,
      "title": program.title,
      "descr": program.descr,
      "steps": ''
    };

    var tmpSteps = <String>{};

    for (int i = 0; i < program!.steps.length; i++) {
      tmpSteps.add(jsonEncode(program!.steps[i]));
    }

    List<String> tmpStepsList =
        tmpSteps.map((item) => item.toString()).toList();

    programCopy["steps"] = jsonEncode(tmpStepsList);

    return jsonEncode(programCopy);
  }

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

  fromJson(Map<String, dynamic> json) {
    // print('fromJson');
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
  final program =
      programs.firstWhereOrNull((element) => element!.programId == programId);

  return program;
}
