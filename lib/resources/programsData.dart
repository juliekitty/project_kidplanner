import 'package:project_kidplanner/src/classes/program.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget stepDefault({picture}) {
  return new Center(
    child: Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: Text(
          'Dress up',
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: 500,
          height: 500,
          child: SvgPicture.asset(
              (picture != null ? picture : 'assets/images/clock.svg'),
              semanticsLabel: ''),
        ),
      ),
    ]),
  );
}

// PROGRAM STEPS
final stepDress = ProgramStep(
    title: 'Dress up',
    duration: Duration(seconds: 10),
    widget: stepDefault(picture: "assets/images/clothing.svg"),
    picture: "assets/images/clothing.svg");
final stepBfast = ProgramStep(
    title: 'Eat your breakfast',
    duration: Duration(seconds: 5),
    widget: stepDefault(),
    picture: "assets/images/cereal.svg");
final ProgramStep stepTeeth = ProgramStep(
    title: 'Tooth brushing',
    duration: Duration(seconds: 10),
    widget: new Center(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
          child: Text(
            'Tooth brushing',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 500,
            height: 500,
            child: SvgPicture.asset('assets/images/eucalyp-brush-teeth.svg',
                semanticsLabel: ''),
          ),
        ),
      ]),
    ),
    picture: 'assets/images/eucalyp-brush-teeth.svg');
final stepToilet = ProgramStep(
    title: 'Toilet',
    duration: Duration(seconds: 5),
    widget: stepDefault(),
    picture: 'assets/images/eucalyp-shower.svg');
final stepPrepareBag = ProgramStep(
    title: 'Prepare your bag',
    duration: Duration(seconds: 5),
    widget: stepDefault(),
    picture: 'assets/images/backpack.svg');
final stepCheckBag = ProgramStep(
    title: 'Check your bag',
    duration: Duration(seconds: 5),
    widget: stepDefault(),
    picture: 'assets/images/backpack.svg');

final stepWater = ProgramStep(
    title: 'Drink some water',
    duration: Duration(seconds: 5),
    widget: stepDefault(),
    picture: "assets/images/water.svg");
final stepPyjama = ProgramStep(
    title: 'Put your pyjama on',
    duration: Duration(seconds: 5),
    widget: stepDefault(),
    picture: "assets/images/pyjamas.svg");
final stepForOutside = ProgramStep(
    title: 'Dress for outside',
    duration: Duration(seconds: 5),
    widget: stepDefault(),
    picture: "assets/images/raincoat.svg");
final stepEndBed =
    ProgramStep(title: 'Go to bed', picture: 'assets/images/bed.svg');

// PROGRAMS
final Program morning = Program('morning', 'Morning Routine', 'Time to get up!',
    [stepDress, stepBfast, stepTeeth, stepPrepareBag, stepForOutside]);

final Program bedtime = Program('bedtime', 'Bedtime', 'Time to go to bed!',
    [stepCheckBag, stepPyjama, stepTeeth, stepToilet, stepWater, stepEndBed]);

final List<Program> programs = [bedtime, morning];
