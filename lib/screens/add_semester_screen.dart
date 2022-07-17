import 'package:flutter/material.dart';

import '../models/module.dart';

class AddSemesterScreen extends StatefulWidget {
  const AddSemesterScreen({Key? key}) : super(key: key);

  @override
  State<AddSemesterScreen> createState() => _AddSemesterScreenState();
}

class _AddSemesterScreenState extends State<AddSemesterScreen> {
  var semesters = [1, 2, 3, 4, 5, 6, 7, 8];
  List<Module> modules = [
    Module(code: 'CS-2022', name: "Object Oriented Programming", credits: 3.0),
    Module(code: 'CS-2032', name: "Computer Architecture", credits: 3.0),
    Module(
        code: 'CS-2042', name: "Data Structures and Algorithms", credits: 2.5),
    Module(code: 'MA-1032', name: "Numerical Methods", credits: 3.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Semester"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Semester"),
                DropdownButton(
                  items: semesters
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                  onChanged: (number) {
                    print(number);
                  },
                  hint: const Text("Select a number"),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                  2: IntrinsicColumnWidth(),
                },
                children: modules
                    .map((e) => TableRow(children: [
                  TableCell(child: Padding(padding: const EdgeInsets.all(4),child: FittedBox(child: Text(e.code)))),
                  TableCell(child: Padding(padding: const EdgeInsets.all(4),child: FittedBox(child: Text(e.name, style: const TextStyle(fontSize: 20),)))),
                  TableCell(child: Padding(padding: const EdgeInsets.all(4),child: FittedBox(child: Text(e.credits.toString()))))
                ]))
                    .toList(),
              ),
            ),
            ElevatedButton(onPressed: (){}, child: const Text("Add a Module"))
          ],
        ),
      ),
    );
  }
}
