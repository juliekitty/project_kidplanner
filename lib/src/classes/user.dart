import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

abstract class User {
  String name;
  int id;
  User(this.id, this.name);
}

// Participant
class Participant extends User {
  // programs that the user have access to
  List<Program> programs; // TODO implement Participant.programs
  int score;

  Participant({id, name, this.score}) : super(id, name);

  int addToScore(int addedPoints) {
    this.score += addedPoints;
    this.insertParticipant(this);
    globals.userNotifier.value = this.score;
    return this.score;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': (id != null ? id : 0),
      'name': name,
      'score': (score != null ? score : 0),
    };
  }

  @override
  String toString() {
    return 'Participant{id: $id, name: $name, score: $score}';
  }

  Future<Participant> currentUser() async {
    // TODO implement with last ID stored in local storage
    print(await Participant().participants());
    print('Use participant ID 1');
    return await Participant().getParticipant(1);
  }

  // SQ Lite functions
  //
  Future<Database> openSQLiteDatabase() async {
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

    var requestResult = await this.getParticipant(participant.id);
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

  Future<List<Participant>> participants() async {
    final Database db = await openSQLiteDatabase();

    final List<Map<String, dynamic>> maps = await db.query('participants');

    // Convert the List<Map<String, dynamic> into a List<Participant>.
    return List.generate(maps.length, (i) {
      return Participant(
        id: maps[i]['id'],
        name: maps[i]['name'],
        score: maps[i]['score'],
      );
    });
  }

  Future<void> updateParticipant(Participant participant) async {
    final db = await openSQLiteDatabase();
    print('updateParticipant ${participant.id} ${participant.toMap()}');
    await db.update(
      'participants',
      participant.toMap(),
      where: "id = ?",
      whereArgs: [participant.id],
    );
    print(await Participant().participants());
  }

  Future<Participant> getParticipant(int id) async {
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
      print('no Participant in DB');
      print('use globals.exampleParticipant');
      return globals.exampleParticipant;
    }

    return Participant(
      id: maps[0]['id'],
      name: maps[0]['name'],
      score: maps[0]['score'],
    );
  }

  Future<void> deleteParticipant(int id) async {
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
