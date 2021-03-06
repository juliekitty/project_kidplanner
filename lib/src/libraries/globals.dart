library project_kidplanner.globals;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/classes/user.dart';

import 'programsData.dart' as programsData;

// Participant and Programs

Participant exampleParticipant =
    Participant(id: 1, name: '', score: 0, programs: programsData.programs);

ValueNotifier<int?> userNotifier = ValueNotifier(currentParticipant.score);

Participant currentParticipant = exampleParticipant;

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

const profileListDebugBoxDecoration =
    BoxDecoration(color: Colors.yellow, border: profileListBorders);

// Audio constants
const timerFinishedAudio = "Cool-alarm-tone-notification-sound.mp3";
const programStepAudio = "Ticking-clock-sound.mp3";
const pointsAdd = "Video-game-bonus-bell-sound-effect.mp3";
const gameLoose = "Error-beep-sound-effect.mp3";
const pointsLoose = "Single-coin-dropping.mp3";
const audioFilesPrefix = 'assets/audio/';
final audioPlayer = AudioPlayer();
