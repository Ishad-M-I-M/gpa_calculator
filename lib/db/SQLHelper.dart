import 'package:path/path.dart';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/module.dart';

class SQLHelper {
  static Future<void> _createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE modules(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        code TEXT NOT NULL UNIQUE,
        name TEXT NOT NULL,
        credits REAL NOT NULL,
        semester INTEGER NOL NULL,
        result STRING NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> _db() async {
    return sql.openDatabase(
      join(await sql.getDatabasesPath(), 'gpa_calculator.db'),
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await _createTables(database);
      },
    );
  }

  // Create new item (Module)
  static Future<int> createModule(Module module) async {
    final db = await SQLHelper._db();

    final id = await db.insert('modules', module.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (Modules)
  static Future<List<Map<String, dynamic>>> getModules() async {
    final db = await SQLHelper._db();
    return db.query('modules', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getModulesWhere(Map<String, String> whereArgs) async{
    final db = await SQLHelper._db();
    final whereQuery = whereArgs.entries.fold("", (previousValue, element) => "$previousValue and ${element.key} = ${element.value}");
    print(whereQuery);
    return db.query('modules', where: whereQuery);
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getModule(int id) async {
    final db = await SQLHelper._db();
    return db.query('modules', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update
  static Future<int> updateModule(Module module) async {
    final db = await SQLHelper._db();
    final data = module.toMap();
    data.addAll({
      'createdAt': DateTime.now().toString()
    });

    final result =
    await db.update('modules', data, where: "id = ?", whereArgs: [module.id]);
    return result;
  }

  // Delete
  static Future<void> deleteModule(int id) async {
    final db = await SQLHelper._db();
    try {
      await db.delete("modules", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}