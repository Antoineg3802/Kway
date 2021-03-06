import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:kway/models/city.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ABANDON DE SQFLITE CAR PROBLEME D'EMULATEUR DONC IMPOSSIBLE DE TESTER SI LA BDD MARCHE

// Future<Database> getDb() async {
//   // Get a location using getDatabasesPath
//   var databasesPath = await getDatabasesPath();
//   String path = join(databasesPath, 'kway.db');

// // Delete the database
//   await deleteDatabase(path);

// // open the database
//   Database database = await openDatabase(path, version: 1,
//       onCreate: (Database db, int version) async {
//     // When creating the db, create the table
//     await db.execute('CREATE TABLE City (id INTEGER PRIMARY KEY, name TEXT)');
//   });

//   return database;
// }

// Future<void> insertCity(String city) async {
//   print(city);
//   // Get a reference to the database.
//   final db = await getDb();
//   await db.insert(
//     'City',
//     {'name': city},
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
// }
var lengthCityList = 0;

Future<void> writeData(String name) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? items = prefs.getStringList('Cities');
  if (items == null) {
    await prefs.setStringList('Cities', <String>[name]);
    lengthCityList = 1;
  } else {
    items.add(name);
    await prefs.setStringList('Cities', items);
  }
}

Future<void> deleteData(String name) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? items = prefs.getStringList('Cities') ?? [];
  if (items?.length != null) {
    for (int i = 0; i < items!.length; i++) {
      if (items[i] == name) {
        items.removeWhere((item) => item == name);
      }
    }
  }
  prefs.setStringList('Cities', items!);
}

Future<List<String>> getAllData() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? items = prefs.getStringList('Cities');
  if (items == null) {
    return [''];
  }
  return items.toList();
}

Future<void> getCountData() async {
  final prefs = await SharedPreferences.getInstance();
  var result = prefs.getStringList('Cities')!.length;
  lengthCityList = result.toInt();
}
