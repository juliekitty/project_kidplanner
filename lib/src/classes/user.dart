import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

abstract class User {
  String? name;
  int? id;
  User(this.id, this.name);
}

// Participant
class Participant extends User {
  // programs that the user have access to
  List<Program?>? programs; // TODO implement Participant.programs
  int? score;

  Participant({id, name, this.score, programs}) : super(id, name);

  int? addToScore(int addedPoints) {
    if (score != null) score = score! + addedPoints;
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

  Map<String, dynamic> toMap() {
    List<String> programConverted = [];
    if (programs != null && programs!.isNotEmpty) {
      for (int i = 0; i < programs!.length; i++) {
        programConverted.add(jsonEncode(programs![i]));
      }
    }

    return {
      'id': (id ?? 0),
      'name': name,
      'score': (score ?? 0),
      'programs': programConverted.toString(),
    };
  }

  @override
  String toString() {
    return 'Participant{id: $id, name: $name, score: $score, programs: $programs}';
  }

  Future<Participant> currentUser() async {
    // TODO implement with last ID stored in local storage
    print('getAllParticipants');
    print(await Participant.getAllParticipants());
    print('FORCE Use participant ID 1');
    return await Participant.getParticipant(1);
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

    var requestResult = await Participant.getParticipant(participant.id);
    if (requestResult == globals.exampleParticipant) {
      print('insertParticipant ${participant.toString()}');
      await db.insert(
        'participants',
        participant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      await updateParticipant(participant);
    }
  }

  static Future<List<Participant>> getAllParticipants() async {
    final Database db = await openSQLiteDatabase();

    final List<Map<String, dynamic>> maps = await db.query('participants');

    // Convert the List<Map<String, dynamic> into a List<Participant>.
    return List.generate(maps.length, (i) {
      return Participant(
        id: maps[i]['id'],
        name: maps[i]['name'],
        score: maps[i]['score'],
        programs: maps[i]['programs'],
      );
    });
  }

  static Future<void> updateParticipant(Participant participant) async {
    final db = await openSQLiteDatabase();

    var participantMap = participant.toMap();

    print('updateParticipant ${participant.id} ${participantMap['programs']}');
    var update = await db.update(
      'participants',
      participantMap,
      where: "id = ?",
      whereArgs: [participant.id],
    );
    print(
        'updateParticipant row updated: $update ${await Participant.getParticipant(1)} ');
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
      print('no Participant in DB, use globals.exampleParticipant');
      return globals.exampleParticipant;
    }

    print('getParticipant ${maps[0].runtimeType} ${maps[0]} ');

    var programsDecoded = jsonDecode(maps[0]['programs']);

    return Participant(
      id: maps[0]['id'],
      name: maps[0]['name'],
      score: maps[0]['score'],
      programs: programsDecoded,
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
