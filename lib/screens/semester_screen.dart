import 'package:flutter/material.dart';

import '../db/SQLHelper.dart';
import '../models/module.dart';
import '../models/semester.dart';
import '../widgets/module_list_tile.dart';

class SemesterScreen extends StatefulWidget {
  final int semester;

  const SemesterScreen({Key? key, required this.semester}) : super(key: key);

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  late Future<Semester> semester;

  @override
  void initState() {
    super.initState();
    semester = getSemester();
  }

  Future<Semester> getSemester() async {
    List<Module> modules = await SQLHelper.getModulesWhere(
        {"semester": widget.semester.toString()});
    return Semester(semester: widget.semester, modules: modules);
  }

  Widget _getView(AsyncSnapshot<Semester> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Center(
        child: Text("Error: ${snapshot.error}"),
      );
    } else if ((snapshot.data as Semester).modules.isEmpty) {
      return const Center(
        child: Text("No modules found"),
      );
    } else {
      return ListView.builder(
        itemCount: (snapshot.data as Semester).modules.length,
        itemBuilder: (context, index) {
          return ModuleListTile(
            module: (snapshot.data as Semester).modules[index],
          );
        },
      );
    }
  }

  Future<void> _refresh() async {
    setState(() {
      semester = getSemester();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Semester ${widget.semester}"),
        ),
        body: FutureBuilder<Semester>(
          initialData: Semester(semester: widget.semester, modules: []),
          future: getSemester(),
          builder: (context, snapshot) {
            return RefreshIndicator(
                onRefresh: _refresh, child: _getView(snapshot));
          },
        ));
  }
}
