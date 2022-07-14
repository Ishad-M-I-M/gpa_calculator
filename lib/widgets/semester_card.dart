import 'package:flutter/material.dart';

class Semester extends StatelessWidget {
  final int semester;
  final Function onTap;
  const Semester({required this.semester, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: const Card(
        color: Colors.deepPurpleAccent,
        child: Text("Semester 1"),
      ),
    );
  }
}
