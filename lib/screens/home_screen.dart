import 'package:flutter/material.dart';

import '../db/SQLHelper.dart';

import '../config/calculations.dart';

import './semester_screen.dart';
import './add_semester_screen.dart';
import './settings_screen.dart';

import '../widgets/semester_card.dart';

import '../models/semester.dart';
import '../models/module.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Module> modules = [];

  late Future<double> cgpa;
  late Future<List<int>> semesters;

  @override
  initState(){
    super.initState();
    cgpa = getCGPA();
    semesters = SQLHelper.getSemesters();
  }

  Future<List<Module>> loadModules() async {
    List<Module> modulesFetched = await SQLHelper.getModules();
    return modulesFetched;
  }

  void navigateToSemesterScreen(BuildContext context, int semester) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SemesterScreen(
              semester: semester,
            )));
  }

  void navigateToAddSemesterScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => AddSemesterScreen(
              updateModule: updateModule,
              deleteModule: deleteModule,
              onSubmit: addSemester,
              existingSemesters: const [],
            )));
  }

  void navigateToSettingsScreen(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const SettingsScreen()));
  }

  void addSemester(Semester semester) {
    setState(() {
      modules.addAll(semester.modules);
    });
  }

  void deleteModule(int moduleId){
    SQLHelper.deleteModule(moduleId);
    setState((){
      modules = modules.where((element) => element.id != moduleId).toList();
    });
  }

  void updateModule(Module updatedModule){
    SQLHelper.updateModule(updatedModule);
    List<Module> updatedModules = modules.where((module)=> module.id != updatedModule.id).toList();
    updatedModules.add(updatedModule);
    setState((){
      modules = updatedModules;
    });
  }

  Future<void> _refresh() async{
    setState((){
      cgpa = getCGPA();
      semesters = SQLHelper.getSemesters();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()=> navigateToSettingsScreen(context), icon: const Icon(Icons.settings))
        ],
        title: const Text("GPA Calculator"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<double>(
                future : cgpa,
                initialData: 0,
                builder: (context, snapshot) {
                  return
                  snapshot.hasData?
                    Text("Current GPA: ${snapshot.data?.toStringAsFixed(2)}", style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor))
                      :
                    const Text("Loading...", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
                },
              )
            ),
            Flexible(
              child: FutureBuilder<List<int>>(
                initialData: const <int>[],
                future: semesters,
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: 3,
                        children: (snapshot.data as List<int>).map((sem) {
                          return SemesterCard(
                            semester: sem,
                            onTap: (ctx) => navigateToSemesterScreen(context, sem),
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                child: OutlinedButton(
                    onPressed: () => navigateToAddSemesterScreen(context),
                    child: const Text("Add Semester"))),
          ],
        ),
      ),
    );
  }
}
