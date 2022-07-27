import 'package:flutter/material.dart';

import '../models/semester.dart';

import '../config/calculations.dart';

class SemesterCard extends StatefulWidget {
  final Semester semester;
  final Function onTap;
  const SemesterCard({required this.semester, required this.onTap, Key? key})
      : super(key: key);

  @override
  State<SemesterCard> createState() => _SemesterCardState();
}

class _SemesterCardState extends State<SemesterCard> {
  double sgpa = 0;

  void loadSGPA() async{
    double sgpa_ = await getSGPA(widget.semester);
    setState((){
      sgpa = sgpa_;
    });
  }
  @override
  Widget build(BuildContext context) {
    loadSGPA();
    return InkWell(
      onTap: () => widget.onTap(context),
      child: Card(
        color: Colors.deepPurpleAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                  child: Text(
                "Semester ${widget.semester.semester}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                    textAlign: TextAlign.center,
              )),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Credits Enrolled: ${getEnrolledCredits(widget.semester)}",
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      "SGPA: ${sgpa.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
