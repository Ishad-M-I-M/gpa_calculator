import 'package:flutter/material.dart';

class SemesterScreen extends StatelessWidget {
  const SemesterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Semester screen"),),
      body: const Center(child: Text("This is Semester Screen"),),
    );
  }
}
