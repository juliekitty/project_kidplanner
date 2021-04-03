import 'package:flutter/material.dart';

class Program {
  // Eigenschaften
  String programId;
  String title;
  String descr;
  List<ProgramStep> steps;

  // Konstruktor
  Program(this.programId, this.title, this.descr, this.steps);
}

class ProgramStep {
  // Eigenschaften
  String title;
  Duration duration;
  Widget widget;
  String picture;

  // Konstruktor
  ProgramStep({this.title, this.duration, this.widget, this.picture});
}

/// Find a program in the list using firstWhere method.
Program findProgramUsingFirstWhere(List<Program> programs, String programId) {
  final program = programs
      .firstWhere((element) => element.programId == programId, orElse: () {
    return null;
  });
  return program;
}
