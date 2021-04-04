import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Program {
  // Eigenschaften
  String programId;
  String title;
  String descr;
  List<ProgramStep> steps;

  // Konstruktor
  Program(this.programId, this.title, this.descr, this.steps);

  @override
  String toString() {
    return this.title;
  }
}

class ProgramStep {
  // Eigenschaften
  String title;
  Duration duration;
  Widget widget;
  String picture;

  // Konstruktor
  ProgramStep({this.title, this.duration, this.widget, this.picture});

  Widget stepDefault() {
    return new Center(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
          child: Text(
            this.title,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 500,
            height: 500,
            child: SvgPicture.asset(
                (this.picture != null
                    ? this.picture
                    : 'assets/images/clock.svg'),
                semanticsLabel: ''),
          ),
        ),
      ]),
    );
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
