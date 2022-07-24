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
  List<Module> modules = [];

  void loadModules() async {
    List<Module> modulesFetched = await SQLHelper.getModules();
    setState(() {
      modules = modulesFetched;
    });
  }

  List<Semester> getSemesters(){
    Map<int, Semester> semesterMap = {};
    for (Module module in modules) {
      if (semesterMap.keys.toList().contains(module.semester)) {
        semesterMap[module.semester]?.modules.add(module);
      } else {
        semesterMap[module.semester] =
            Semester(semester: module.semester, modules: [module]);
      }
    }
    return semesterMap.values.toList();
  }

  Semester getSemester(int semester){
    return Semester(semester:semester, modules: modules.where((element) => element.semester == semester).toList() );
  }

  void navigateToSemesterScreen(BuildContext context, int semester) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SemesterScreen(
              semester: getSemester(semester)
            )));
  }

  void navigateToAddSemesterScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => AddSemesterScreen(
              onSubmit: addSemester,
              existingSemesters: getSemesters(),
            )));
  }

  void addSemester(Semester semester) {
    setState(() {
      modules.addAll(semester.modules);
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
            child: Text("Current GPA: ${getCGPA(getSemesters()).toStringAsFixed(2)}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Flexible(
            child: GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 3,
              children: getSemesters().map((sem) {
                return SemesterCard(
                  semester: sem,
                  onTap: (ctx) => navigateToSemesterScreen(context, sem.semester),
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
