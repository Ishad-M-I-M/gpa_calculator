import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

import './screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
      join(await getDatabasesPath(), 'app.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE module (id INTEGER AUTOINCREMENT PRIMARY KEY, semester INTEGER, moduleCode TEXT, moduleName TEXT, moduleCredits REAL, moduleGrade TEXT)",
      );
    },
    version: 1,
  );
  runApp(const GPACalculatorApp());
}

class GPACalculatorApp extends StatelessWidget {
  const GPACalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Text Calculator",
      home: const HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        )
      ),
    );
  }
}
