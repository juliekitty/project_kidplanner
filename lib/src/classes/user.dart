import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;
import 'package:project_kidplanner/src/libraries/programsData.dart'
    as programsData;
import 'package:sqflite/sqflite.dart';

abstract class User {
  String? name;
  int? id;
  User(this.id, this.name);

  @override
  String toString() {
    return 'User {id: $id, name: $name}';
  }
}

// Participant
class Participant extends User {
  // programs that the user have access to
  List<Program?>? programs;
  int? score;

  Participant({id, name, this.score, this.programs}) : super(id, name);

  int? addToScore(int addedPoints) {
    if (score != null) score = score! + addedPoints;
    debugPrint('--- insertParticipant from addToScore');
    insertParticipant(this);
    globals.userNotifier.value = score;
    AudioCache player = AudioCache(
        prefix: globals.audioFilesPrefix, fixedPlayer: globals.audioPlayer);
    if (addedPoints > 0) {
      player.play(globals.pointsAdd);
    } else {
      player.play(globals.pointsLoose);
    }
    return score;
  }

  factory Participant.fromRawJson(String str) =>
      Participant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        name: json["name"],
        id: json["id"],
        score: json["score"],
        programs: List<Program>.from(
            json["programs"].map((x) => Program.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "score": score,
        "programs":
            jsonEncode(List<dynamic>.from(programs!.map((x) => x!.toJson()))),
      };

  @override
  String toString() {
    return 'Participant{id: $id, name: $name, score: $score, programs: ${jsonEncode(programs)}}';
  }

  Future<Participant> currentUser() async {
    // TODO implement with last ID stored in local storage
    // print('getAllParticipants');
    // print(await Participant.getAllParticipants());
    debugPrint('FORCE Use participant ID 1');
    return await Participant.getParticipant(1);
  }

  /*
    Create a new participant
    with 1 as ID
    with the default programs
    width the name passed as argument
  */
  Participant initParticipant({name = ''}) {
    // TODO generate Identifier for new User in DB
    Participant newParticipant = Participant(
        id: 1, name: name, score: 0, programs: programsData.programs);
    debugPrint('------ initParticipant using default programs: ');
    debugPrint(jsonEncode(newParticipant.programs));
    Participant().insertParticipant(newParticipant);
    return newParticipant;
  }

  /*
    Create a new participant
    with 1 as ID
    with the default programs
    width the name passed as argument
  */
  static Future<void> logout() async {
    debugPrint('------ LOGOUT & delete participant --- debug only');
    // final Participant currentUser = await Participant().currentUser();
    globals.currentParticipant.name = '';
    // DEBUG
    Participant.deleteParticipant(1);
  }

  // SQ Lite functions
  //
  static Future<Database> openSQLiteDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'kid_planner_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE participants(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, score INTEGER, programs TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertParticipant(Participant participant) async {
    final Database db = await openSQLiteDatabase();
    debugPrint(
        '------ insertParticipant programs ${jsonEncode(participant.programs)}');
    var requestResult = await Participant.getParticipant(participant.id);
    if (requestResult == globals.exampleParticipant) {
      // if getParticipant returns exampleParticipant, this means
      // the user ID was not found and the user must be created
      debugPrint('insertParticipant asString ${participant.toString()}');
      debugPrint(
          'insertParticipant programs ${jsonEncode(participant.programs)}');

      await db.insert(
        'participants',
        participant.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      await saveUpdatedParticipant(participant);
    }
  }

  static Future<List<Participant>> getAllParticipants() async {
    final Database db = await openSQLiteDatabase();

    final List<Map<String, dynamic>> maps = await db.query('participants');

    // Convert the List<Map<String, dynamic> into a List<Participant>.
    return List.generate(maps.length, (i) {
      List programListDecoded = jsonDecode(maps[i]['programs']);

      List<Program?> programList = [];

      for (var i = 0; i < programListDecoded.length; i++) {
        programList.add(Program.fromJson(programListDecoded[i]));
      }

      return Participant(
        id: maps[i]['id'],
        name: maps[i]['name'],
        score: maps[i]['score'],
        programs: programList,
      );
    });
  }

  static Future<void> saveUpdatedParticipant(Participant participant) async {
    final db = await openSQLiteDatabase();

    var participantMap = participant.toJson();

    // print('saveUpdatedParticipant ${participant.id} ${participantMap['programs']}');
    // var update =
    await db.update(
      'participants',
      participantMap,
      where: "id = ?",
      whereArgs: [participant.id],
    );
    // print('saveUpdatedParticipant row updated: $update ${await Participant.getParticipant(1)} ');
  }

  static Future<Participant> getParticipant(int? id) async {
    // Get a reference to the database.
    final Database db = await openSQLiteDatabase();

    // Query the table for all The Participants.
    final List<Map<String, dynamic>> maps = await db.query(
      'participants',
      where: "id = ?",
      whereArgs: [id],
    );

    // Convert the List<Map<String, dynamic> into a List<Participant>.
    if (maps.isEmpty) {
      // print('no Participant in DB, use globals.exampleParticipant');
      return globals.exampleParticipant;
    }

    // print('getParticipant ${maps[0].runtimeType} ${maps[0]} ');

    List programListDecoded = jsonDecode(maps[0]['programs']);
    List<Program?> programList = [];
    for (var i = 0; i < programListDecoded.length; i++) {
      programList.add(Program.fromJson(programListDecoded[i]));
    }

    debugPrint('Participant ID found in DB, return Participant');
    return Participant(
      id: maps[0]['id'],
      name: maps[0]['name'],
      score: maps[0]['score'],
      programs: programList,
    );
  }

  static Future<void> deleteParticipant(int id) async {
    final db = await openSQLiteDatabase();

    await db.delete(
      'participants',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

// Can manage a participant: a parent for example
class ParticipantManager extends User {
  List<Participant> managedParticipants;

  ParticipantManager(id, name, this.managedParticipants) : super(id, name);
}
