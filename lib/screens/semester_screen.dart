import 'package:flutter/material.dart';

import '../db/SQLHelper.dart';

import '../models/semester.dart';
import '../models/module.dart';

import '../widgets/module_list_tile.dart';

class SemesterScreen extends StatelessWidget {
  final int semester;
  const SemesterScreen({Key? key, required this.semester}) : super(key: key);

  Future<Semester> getSemester() async{
    List<Module> modules = await SQLHelper.getModulesWhere({"semester": semester.toString()});
    return Semester(semester: semester, modules: modules);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Semester $semester"),),
      body: FutureBuilder<Semester>(
        initialData: Semester(semester: semester, modules: []),
        future: getSemester(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting ){
            return const CircularProgressIndicator();
          }
          else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"),);
          }
          else if ((snapshot.data as Semester).modules.isEmpty){
            return const Center(child: Text("No modules found"),);
          }
          else{
            return ListView.builder(
              itemCount: (snapshot.data as Semester).modules.length,
              itemBuilder: (context, index) {
                return ModuleListTile(module: (snapshot.data as Semester).modules[index],);
              },
            );
          }
        },
    )
    );
  }
}
