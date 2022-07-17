import 'package:flutter/material.dart';

class SemesterScreen extends StatelessWidget {
  final int number;
  const SemesterScreen({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Semester screen"),),
      body: const Center(child: Text("This is Semester Screen"),),
    );
  }
}
