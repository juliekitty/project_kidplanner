library project_kidplanner.programs_data;

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// PROGRAM STEPS
// define widget in class object only for specific widgets

final stepDress = ProgramStep(
    title: 'Dress up',
    duration: Duration(minutes: 3),
    picture: "assets/images/clothing.svg");
final stepBfast = ProgramStep(
    title: 'Eat your breakfast',
    duration: Duration(seconds: 5),
    picture: "assets/images/cereal.svg");
final ProgramStep stepTeeth = ProgramStep(
    title: 'Tooth brushing',
    duration: Duration(seconds: 10),
    picture: 'assets/images/eucalyp-brush-teeth.svg',
    animation: 'assets/images/animated/brush-teeth-gif-6.gif');

final stepToilet = ProgramStep(
    title: 'Toilet',
    duration: Duration(seconds: 5),
    picture: 'assets/images/eucalyp-shower.svg');
final stepPrepareBag = ProgramStep(
    title: 'Prepare your bag',
    duration: Duration(seconds: 5),
    picture: 'assets/images/backpack.svg');
final stepCheckBag = ProgramStep(
    title: 'Check your bag',
    duration: Duration(seconds: 5),
    picture: 'assets/images/backpack.svg');

final stepWater = ProgramStep(
    title: 'Drink some water',
    duration: Duration(seconds: 5),
    picture: "assets/images/water.svg");
final stepPyjama = ProgramStep(
    title: 'Put your pyjama on',
    duration: Duration(seconds: 5),
    picture: "assets/images/pyjamas.svg");
final stepForOutside = ProgramStep(
    title: 'Dress for outside',
    duration: Duration(seconds: 5),
    picture: "assets/images/raincoat.svg");
final stepEndBed = ProgramStep(
    title: 'Go to bed',
    duration: Duration(seconds: 1),
    picture: 'assets/images/bed.svg');

// PROGRAMS
final Program morning = Program('morning', 'Morning Routine', 'Time to get up!',
    [stepDress, stepBfast, stepTeeth, stepPrepareBag, stepForOutside]);

final Program bedtime = Program('bedtime', 'Bedtime', 'Time to go to bed!',
    [stepCheckBag, stepPyjama, stepTeeth, stepToilet, stepWater, stepEndBed]);

final List<Program> programs = [bedtime, morning];
