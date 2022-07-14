import 'package:flutter/material.dart';

import './semester_screen.dart';

import '../widgets/semester_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void navigateToSemesterScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SemesterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GPA Calculator"),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, mainAxisSpacing: 10, mainAxisExtent: 100),
        children: [
          Semester(
            semester: 1,
            onTap: navigateToSemesterScreen,
          ),
        ],
      ),
    );
  }
}
