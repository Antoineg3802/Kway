import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:kway/models/city.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final Database database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
  // When creating the db, create the table
  await db.execute(
      'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
});

Future<void> insertCity(String city) async {
  print(city);
  // Get a reference to the database.
  final db = await database;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'City',
    {'name': city},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
