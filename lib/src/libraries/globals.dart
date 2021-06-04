library project_kidplanner.globals;

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/classes/user.dart';
import 'programsData.dart' as programsData;
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// Participant and Programs
Participant exampleParticipant = Participant(id: 1, name: '', score: 0);

ValueNotifier<int?> userNotifier = ValueNotifier(currentParticipant.score);

late Participant currentParticipant;

List<Program?> defaultPrograms = programsData.programs;

// Themes Infos
const profileListBorders = Border(
  bottom: BorderSide(color: Colors.grey, width: 0.0),
  top: BorderSide(color: Colors.grey, width: 0.0),
  left: BorderSide(color: Colors.grey, width: 0.0),
  right: BorderSide(color: Colors.grey, width: 0.0),
);

const profileListBoxDecoration = BoxDecoration(
  color: Colors.white,
  border: profileListBorders,
);

// Audio constants
const timerFinishedAudio = "Cool-alarm-tone-notification-sound.mp3";
const programStepAudio = "Ticking-clock-sound.mp3";
const pointsAdd = "Video-game-bonus-bell-sound-effect.mp3";
const gameLoose = "Error-beep-sound-effect.mp3";
const pointsLoose = "Single-coin-dropping.mp3";
const audioFilesPrefix = 'audio/';
final audioPlayer = AudioPlayer();
