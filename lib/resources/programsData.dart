import 'package:project_kidplanner/src/classes/program.dart';

final ProgramStep stepTeeth = ProgramStep(
    title: 'Tooth brushing',
    duration: 4,
    picture: 'assets/images/eucalyp-brush-teeth.svg');
final stepToilet = ProgramStep(
    title: 'Toilet', duration: 6, picture: 'assets/images/eucalyp-shower.svg');
final stepPrepareBag = ProgramStep(
    title: 'Prepare your bag',
    duration: 6,
    picture: 'assets/images/backpack.svg');
final stepCheckBag = ProgramStep(
    title: 'Check your bag',
    duration: 6,
    picture: 'assets/images/backpack.svg');
final stepDress = ProgramStep(
    title: 'Dress up', duration: 6, picture: "assets/images/clothing.svg");
final stepBfast = ProgramStep(
    title: 'Eat your breakfast',
    duration: 6,
    picture: "assets/images/cereal.svg");
final stepWater = ProgramStep(
    title: 'Drink some water', duration: 6, picture: "assets/images/water.svg");
final stepPyjama = ProgramStep(
    title: 'Put your pyjama on',
    duration: 6,
    picture: "assets/images/pyjamas.svg");
final stepForOutside = ProgramStep(
    title: 'Dress for outside',
    duration: 6,
    picture: "assets/images/raincoat.svg");
final stepEndBed =
    ProgramStep(title: 'Go to bed', picture: 'assets/images/bed.svg');

final Program bedtime = Program('bedtime', 'Bedtime', 'Time to go to bed!',
    [stepCheckBag, stepPyjama, stepTeeth, stepToilet, stepWater, stepEndBed]);
final Program morning = Program('morning', 'Morning Routine', 'Time to get up!',
    [stepDress, stepBfast, stepTeeth, stepPrepareBag, stepForOutside]);

final List<Program> programs = [bedtime, morning];
