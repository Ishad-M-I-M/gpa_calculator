import 'package:flutter/material.dart';

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
  List<Semester> semesters = [
    Semester(semester: 1), Semester(semester: 2), Semester(semester: 3)
  ];

  void navigateToSemesterScreen(BuildContext context, int semester) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) =>  SemesterScreen(number: semester,)));
  }

  void navigateToAddSemesterScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const AddSemesterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GPA Calculator"),
      ),
      body: Column(
        children: [
          Flexible(
            child: GridView.count(
              crossAxisCount: 1,
              children: semesters.map((sem){
                return SemesterCard(semester: sem.semester, onTap: ()=> navigateToSemesterScreen(context, sem.semester),);
              }).toList(),
            ),
          ),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 20, right: 20),
              child: OutlinedButton(
                  onPressed: ()=> navigateToAddSemesterScreen(context) , child: const Text("Add Semester"))),
        ],
      ),
    );
  }
}
