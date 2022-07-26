import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/module.dart';
import '../models/result.dart';

class SQLHelper {
  static const int version = 2;

  static Future<void> _createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS modules(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT NOT NULL UNIQUE,
        name TEXT NOT NULL,
        credits REAL NOT NULL,
        semester INTEGER NOL NULL,
        result STRING NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute("""CREATE TABLE IF NOT EXISTS gpas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        result TEXT NOT NULL UNIQUE,
        gpa REAL NOT NULL
    )
    """);
    try {
      //start with default results
      await database.execute("""
        INSERT INTO gpas(result, gpa) VALUES
        ('A+', 4.2),
        ('A', 4.0),
        ('A-', 3.7),
        ('B+', 3.3),
        ('B', 3.0),
        ('B-', 2.7),
        ('C+', 2.3),
        ('C', 2.0),
        ('C-', 1.7),
        ('D', 1.3),
        ('I-ca', 0),
        ('I-we', 0)
        """);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<sql.Database> _db() async {
    return sql.openDatabase(
      join(await sql.getDatabasesPath(), 'gpa_calculator.db'),
      version: version,
      onCreate: (sql.Database database, int version) async {
        await _createTables(database);
      },
      onUpgrade: (sql.Database database, int version1, int version2) async {
        print("Version $version1 to $version2");
        await _createTables(database);
      }
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
  static Future<List<Module>> getModules() async {
    final db = await SQLHelper._db();
    List<Map<String, dynamic>> results =  await db.query('modules', orderBy: "id");
    return List.generate(results.length, (i) {
      return Module(
        id: results[i]['id'],
        name: results[i]['name'],
        code: results[i]['code'],
        credits: results[i]['credits'],
        semester: results[i]['semester'],
        result: results[i]['result']
      );
    });
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

  // results table queries
  static Future<List<Result>> getGPAs() async{
    final db = await SQLHelper._db();
    List<Map<String, dynamic>> results =  await db.query('gpas', orderBy: "id");
    return List.generate(results.length, (index) {
      return Result(
        id: results[index]['id'],
        result: results[index]['result'],
        gpa: results[index]['gpa']
      );
    });
  }
}