import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    load();
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[Text('Test page for sqlite')],
    );
  }
}

Future<List<dynamic>> load() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final Future<Database> database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'participantgie_database.db'),
    // When the database is first created, create a table to store participants.
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE participants(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  Future<void> insertParticipant(Participant participant) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Participant into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same participant is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'participants',
      participant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Participant>> participants() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Participants.
    final List<Map<String, dynamic>> maps = await db.query('participants');

    // Convert the List<Map<String, dynamic> into a List<Participant>.
    return List.generate(maps.length, (i) {
      return Participant(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<void> updateParticipant(Participant participant) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Participant.
    await db.update(
      'participants',
      participant.toMap(),
      // Ensure that the Participant has a matching id.
      where: "id = ?",
      // Pass the Participant's id as a whereArg to prevent SQL injection.
      whereArgs: [participant.id],
    );
  }

  Future<void> deleteParticipant(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Participant from the database.
    await db.delete(
      'participants',
      // Use a `where` clause to delete a specific participant.
      where: "id = ?",
      // Pass the Participant's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  var julie = Participant(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  // Insert a participant into the database.
  await insertParticipant(julie);

  // Print the list of participants (only Fido for now).
  print(await participants());

  // Update Fido's age and save it to the database.
  julie = Participant(
    id: julie.id,
    name: julie.name,
    age: julie.age + 7,
  );
  await updateParticipant(julie);

  // Print Fido's updated information.
  print(await participants());

  // Delete Fido from the database.
  await deleteParticipant(julie.id);

  // Print the list of participants (empty).
  print(await participants());
}

class Participant {
  final int id;
  final String name;
  final int age;

  Participant({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each participant when using the print statement.
  @override
  String toString() {
    return 'Participant{id: $id, name: $name, age: $age}';
  }
}
