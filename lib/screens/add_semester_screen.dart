import 'package:flutter/material.dart';

import '../db/SQLHelper.dart';

import '../widgets/add_module.dart';
import '../widgets/module_list_tile.dart';

import '../models/semester.dart';
import '../models/module.dart';

class AddSemesterScreen extends StatefulWidget {
  final Function onSubmit;
  final Function deleteModule;
  final Function updateModule;
  final List<Semester> existingSemesters;
  const AddSemesterScreen({this.existingSemesters = const [], required this.deleteModule,required this.onSubmit, required this.updateModule, Key? key}) : super(key: key);

  @override
  State<AddSemesterScreen> createState() => _AddSemesterScreenState();
}

class _AddSemesterScreenState extends State<AddSemesterScreen> {
  var semesters = [1, 2, 3, 4, 5, 6, 7, 8];
  List<Module> modules = [];
  int _semester = 0;

  void displayAddModuleWindow(BuildContext context, int semester) {
    showModalBottomSheet(context: context, builder: (_){
      return AddModule(semester: _semester, addModule: (Module module) async{
        int id = await SQLHelper.createModule(module);
        setState((){
          modules.add(module);
        });
      }, );
    });
  }

  double get totalCredits => modules.fold(0, (sum, module) => sum + module.credits);

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
                    setState((){
                      _semester = number as int;
                      modules = widget.existingSemesters.firstWhere((semester) => semester.semester == number, orElse: () => Semester(semester: number, modules: [])).modules;
                    });
                  },
                  value: _semester == 0? null: _semester,
                  hint: const Text("Select a number"),
                ),
              ],
            ),
            ...modules.map((e) {
              return ModuleListTile(module: e);
            }),
            Padding(padding: const EdgeInsets.all(10),child: Text("Total Credits: $totalCredits")),
            ElevatedButton(onPressed: ()=>displayAddModuleWindow(context, _semester), child: const Text("Add a Module"))
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child : OutlinedButton(
          onPressed: (){
            widget.onSubmit(Semester(semester: _semester, modules: modules));
            Navigator.of(context).pop();
          },
          child: const Text("Submit"),
        ),
      ),
    );
  }
}
