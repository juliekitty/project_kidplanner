import 'package:project_kidplanner/src/classes/program.dart';

Map<String, dynamic> stepTeeth = {
  "title": 'Tooth brushing',
  "duration": 4,
  "picture": 'assets/images/eucalyp-brush-teeth.svg'
};
Map<String, dynamic> stepToilet = {
  "title": 'Toilet',
  "duration": 6,
  "picture": 'assets/images/eucalyp-shower.svg'
};
Map<String, dynamic> stepPrepareBag = {
  "title": 'Prepare your bag',
  "duration": 6,
  "picture": 'assets/images/backpack.svg'
};
Map<String, dynamic> stepCheckBag = {
  "title": 'Check your bag',
  "duration": 6,
  "picture": 'assets/images/backpack.svg'
};
Map<String, dynamic> stepDress = {
  "title": 'Dress up',
  "duration": 6,
  "picture": "assets/images/clothing.svg"
};
Map<String, dynamic> stepBfast = {
  "title": 'Eat your breakfast',
  "duration": 6,
  "picture": "assets/images/cereal.svg"
};
Map<String, dynamic> stepWater = {
  "title": 'Drink some water',
  "duration": 6,
  "picture": "assets/images/water.svg"
};
Map<String, dynamic> stepPyjama = {
  "title": 'Put your pyjama on',
  "duration": 6,
  "picture": "assets/images/pyjamas.svg"
};
Map<String, dynamic> stepForOutside = {
  "title": 'Dress for outside',
  "duration": 6,
  "picture": "assets/images/raincoat.svg"
};
Map<String, dynamic> stepEndBed = {
  "title": 'Go to bed',
  "picture": 'assets/images/bed.svg'
};
final Program bedtime = Program('bedtime', 'Bedtime', 'Time to go to bed!',
    [stepCheckBag, stepPyjama, stepTeeth, stepToilet, stepWater, stepEndBed]);
final Program morning = Program('morning', 'Morning Routine', 'Time to get up!',
    [stepDress, stepBfast, stepTeeth, stepPrepareBag, stepForOutside]);

final List<Program> programs = [bedtime, morning];
