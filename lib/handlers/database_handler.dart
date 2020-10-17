import 'dart:async';

import 'package:access/models/data_result.dart';
import 'package:access/models/personal_details_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  final String _tableName = "personal_details";

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'personal_details_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE " +
              _tableName +
              "(id TEXT PRIMARY KEY, name TEXT, surname TEXT, cellNumber TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertPersonalDetails(
      PersonalDetailsModel personalDetails) async {
    final Database db = await _getDatabase();

    await db.insert(
      _tableName,
      personalDetails.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<DataResult<PersonalDetailsModel>> getPersonalDetails() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(this._tableName);

      PersonalDetailsModel personalDetails = List.generate(maps.length, (i) {
        return PersonalDetailsModel(
          id: maps[i]['id'],
          name: maps[i]['name'],
          surname: maps[i]['surname'],
          cellNumber: maps[i]['cellNumber'],
        );
      }).first;

      return DataResult<PersonalDetailsModel>(success: true, value: personalDetails);
    } on StateError catch(se){
      return DataResult<PersonalDetailsModel>(success: true, value: null, error: se.message);
    }catch (e) {
      return DataResult<PersonalDetailsModel>(success: false, error: "Failed to get personal details from local file store.");
    }
  }

  Future<void> updatePersonalDetails(
      PersonalDetailsModel personalDetails) async {
    final db = await _getDatabase();
    await db.update(
      this._tableName,
      personalDetails.toMap(),
      where: "id = ?",
      whereArgs: [personalDetails.id],
    );
  }

  Future<void> deletePersonalDetails() async {
    final db = await _getDatabase();
    await db.delete(
      this._tableName,
    );
  }
}
