import 'package:flutter/material.dart';

import '../config/calculations.dart';
import '../db/SQLHelper.dart';
import '../models/module.dart';
import '../models/semester.dart';

class SemesterCard extends StatefulWidget {
  final int semester;
  final Function onTap;

  const SemesterCard({required this.semester, required this.onTap, Key? key})
      : super(key: key);

  @override
  State<SemesterCard> createState() => _SemesterCardState();
}

class _SemesterCardState extends State<SemesterCard> {
  Future<Semester> getSemester(int semester) async {
    List<Module> moduleList =
        await SQLHelper.getModulesWhere({"semester": semester.toString()});
    return Semester(semester: semester, modules: moduleList);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Semester>(
        initialData: Semester(semester: widget.semester, modules: []),
        future: getSemester(widget.semester),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
          {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError)
          {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          else
          {
            return InkWell(
              onTap: () => widget.onTap(context),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(3, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Semester ${snapshot.data?.semester}",
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<double>(
                          initialData: 0.0,
                          future: getEnrolledCredits(widget.semester),
                              builder: (context, snapshot){
                                if (snapshot.connectionState == ConnectionState.waiting)
                                {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                else if (snapshot.hasError)
                                {
                                  return Center(child: Text("Error: ${snapshot.error}"));
                                }
                                else
                                {
                                  return Text(
                                    "Credits Enrolled: ${snapshot.data?.toStringAsFixed(2)}",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  );
                                }
                              },
                            ),
                            FutureBuilder<double>(
                              initialData: 0.0,
                              future: getSGPA(widget.semester),
                              builder: (context, snapshot){
                                if (snapshot.connectionState == ConnectionState.waiting)
                                {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                else if (snapshot.hasError)
                                {
                                  return Center(child: Text("Error: ${snapshot.error}"));
                                }
                                else
                                {
                                  return Text(
                                    "SGPA:  ${snapshot.data?.toStringAsFixed(2)}",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
    );
  }
}
