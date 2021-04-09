library project_kidplanner.programs_data;

import 'package:project_kidplanner/src/classes/program.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

// PROGRAM STEPS
// define widget in class object only for specific widgets

final ProgramStep stepDress = ProgramStep(
    title: 'Dress up',
    duration: Duration(minutes: 3),
    picture: "assets/images/clothing.svg");
final ProgramStep stepBfast = ProgramStep(
    title: 'Eat your breakfast',
    duration: Duration(minutes: 7),
    picture: "assets/images/cereal.svg");
final ProgramStep stepTeeth = ProgramStep(
    title: 'Tooth brushing',
    duration: Duration(minutes: 4),
    picture: 'assets/images/eucalyp-brush-teeth.svg',
    animation: 'assets/images/animated/brush-teeth-gif-6.gif');
final ProgramStep stepPrepareBag = ProgramStep(
    title: 'Prepare your schoolbag',
    duration: Duration(minutes: 4),
    picture: 'assets/images/backpack.svg');
final ProgramStep stepForOutside = ProgramStep(
    title: 'Dress for outside',
    duration: Duration(minutes: 4),
    picture: "assets/images/raincoat.svg");

final ProgramStep stepCheckBag = ProgramStep(
    title: 'Check your schoolbag',
    duration: Duration(seconds: 7),
    picture: 'assets/images/backpack.svg');
final ProgramStep stepPyjama = ProgramStep(
    title: 'Put your pyjama on',
    duration: Duration(seconds: 5),
    picture: "assets/images/pyjamas.svg");
final ProgramStep stepTeethNight = ProgramStep(
    title: 'Tooth brushing',
    duration: Duration(seconds: 4),
    picture: 'assets/images/eucalyp-brush-teeth.svg',
    animation: 'assets/images/animated/brush-teeth-gif-6.gif');
final ProgramStep stepToilet = ProgramStep(
    title: 'Toilet',
    duration: Duration(seconds: 5),
    picture: 'assets/images/eucalyp-shower.svg');
final ProgramStep stepWater = ProgramStep(
    title: 'Drink some water',
    duration: Duration(seconds: 5),
    picture: "assets/images/water.svg");
final ProgramStep stepEndBed = ProgramStep(
    title: 'Go to bed',
    duration: Duration(seconds: 1),
    picture: 'assets/images/bed.svg');

// PROGRAMS
final Program morning =
    Program('morning', 'Morning Routine', 'Time to get up!', [
  stepDress,
  stepBfast,
  stepTeeth,
  stepPrepareBag,
  stepForOutside,
]);

final Program bedtime = Program(
    'bedtime', 'Bedtime (quick version)', 'Time to go to bed!', [
  stepCheckBag,
  stepPyjama,
  stepTeethNight,
  stepToilet,
  stepWater,
  stepEndBed
]);

final List<Program> programs = [bedtime, morning];
