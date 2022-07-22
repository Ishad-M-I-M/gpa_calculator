import 'package:flutter/material.dart';

import '../db/SQLHelper.dart';

import '../config/calculations.dart';

import './semester_screen.dart';
import './add_semester_screen.dart';

import '../widgets/semester_card.dart';

import '../models/semester.dart';
import '../models/module.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Semester> semesters = [];

  void loadModules() async {
    List<Module> modules = await SQLHelper.getModules();
    Map<int, Semester> semesterMap = {};
    for (Module module in modules) {
      if (semesterMap.keys.toList().contains(module.semester)) {
        semesterMap[module.semester]?.modules.add(module);
      } else {
        semesterMap[module.semester] =
            Semester(semester: module.semester, modules: [module]);
      }
    }
    setState(() {
      semesters = semesterMap.values.toList();
    });
  }

  void navigateToSemesterScreen(BuildContext context, Semester semester) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SemesterScreen(
              semester: semester,
            )));
  }

  void navigateToAddSemesterScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => AddSemesterScreen(
              onSubmit: addSemester,
              existingSemesters: semesters,
            )));
  }

  void addSemester(Semester semester) {
    setState(() {
      semesters.add(semester);
    });
  }

  @override
  Widget build(BuildContext context) {
    loadModules();
    return Scaffold(
      appBar: AppBar(
        title: const Text("GPA Calculator"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Current GPA: ${getCGPA(semesters).toStringAsFixed(2)}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Flexible(
            child: GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 3,
              children: semesters.map((sem) {
                return SemesterCard(
                  semester: sem,
                  onTap: (ctx) => navigateToSemesterScreen(context, sem),
                );
              }).toList(),
            ),
          ),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 20, right: 20),
              child: OutlinedButton(
                  onPressed: () => navigateToAddSemesterScreen(context),
                  child: const Text("Add Semester"))),
        ],
      ),
    );
  }
}
