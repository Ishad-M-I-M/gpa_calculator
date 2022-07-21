import 'package:flutter/material.dart';

import '../models/semester.dart';

import '../config/constants.dart';

class SemesterCard extends StatelessWidget {
  final Semester semester;
  final Function onTap;
  const SemesterCard({required this.semester, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double creditsEnrolled =
        semester.modules.fold(0, (sum, module) => sum + module.credits);
    double total = semester.modules.fold(0, (sum, module) {
      if (module.result == "Pending") return sum;
      return sum +  (gpaValues[module.result] != null ? module.credits * gpaValues[module.result]!: 0);
    });
    double effectiveCredits = semester.modules.fold(0, (sum, module) {
      if (module.result == "Pending") return sum;
      return sum + module.credits ;
    });

    return InkWell(
      onTap: () => onTap(context),
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
                "Semester ${semester.semester}",
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
                      "Credits Enrolled: $creditsEnrolled",
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      "SGPA: ${(total / effectiveCredits).toStringAsFixed(2)}",
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
