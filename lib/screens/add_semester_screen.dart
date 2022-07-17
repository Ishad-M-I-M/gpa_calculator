import 'package:flutter/material.dart';

class AddSemesterScreen extends StatelessWidget {
  const AddSemesterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Semester"),
      ),
      body: const Center(child: Text("This is Add Semester Screen"),),
    );
  }
}
