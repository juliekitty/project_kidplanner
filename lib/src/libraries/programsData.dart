library project_kidplanner.programs_data;

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/classes/programStep.dart';

// PROGRAM STEPS
// define widget in class object only for specific widgets

final ProgramStep stepDress = ProgramStep(
    id: 'stepDress',
    duration: const Duration(minutes: 5),
    picture: "assets/images/clothing.svg");
final ProgramStep stepBfast = ProgramStep(
    id: 'stepBfast',
    duration: const Duration(minutes: 15),
    picture: "assets/images/cereal.svg");
final ProgramStep stepTeeth = ProgramStep(
    id: 'stepTeeth',
    duration: const Duration(minutes: 4),
    picture: 'assets/images/eucalyp-brush-teeth.svg',
    animation: 'assets/images/animated/brush-teeth-gif-6.gif');
final ProgramStep stepPrepareBag = ProgramStep(
    id: 'stepPrepareBag',
    duration: const Duration(minutes: 4),
    picture: 'assets/images/backpack.svg');
final ProgramStep stepForOutside = ProgramStep(
    id: 'stepForOutside',
    duration: const Duration(minutes: 4),
    picture: "assets/images/raincoat.svg");
final ProgramStep stepFinished = ProgramStep(
    id: 'stepFinished',
    duration: const Duration(seconds: 0),
    picture: 'assets/images/requirement.svg');

final ProgramStep stepCheckBag = ProgramStep(
    id: 'stepCheckBag',
    duration: const Duration(minutes: 4),
    picture: 'assets/images/backpack.svg');
final ProgramStep stepPyjama = ProgramStep(
    id: 'stepPyjama',
    duration: const Duration(minutes: 4),
    picture: "assets/images/pyjamas.svg");
final ProgramStep stepTeethNight = ProgramStep(
    id: 'stepTeethNight',
    duration: const Duration(minutes: 4),
    picture: 'assets/images/eucalyp-brush-teeth.svg',
    animation: 'assets/images/animated/brush-teeth-gif-6.gif');
final ProgramStep stepToilet = ProgramStep(
    id: 'stepToilet',
    duration: const Duration(minutes: 4),
    picture: 'assets/images/eucalyp-shower.svg');
final ProgramStep stepWater = ProgramStep(
    id: 'stepWater',
    duration: const Duration(minutes: 4),
    picture: "assets/images/water.svg");
final ProgramStep stepEndBed = ProgramStep(
    id: 'stepEndBed',
    duration: const Duration(seconds: 0),
    picture: 'assets/images/bed.svg');

// PROGRAMS
final Program morning = Program(
  'morning',
  'Programs.morning.title',
  'Programs.morning.introText',
  [
    stepDress,
    stepBfast,
    stepTeeth,
    stepPrepareBag,
    stepForOutside,
    stepFinished
  ],
  'assets/images/clock.svg',
);

final Program bedtime = Program(
    'bedtime',
    'Programs.bedtime.title',
    'Programs.bedtime.introText',
    [
      stepCheckBag,
      stepPyjama,
      stepTeethNight,
      stepToilet,
      stepWater,
      stepEndBed
    ],
    'assets/images/wake-up.svg');

final List<Program?> programs = [morning, bedtime];
