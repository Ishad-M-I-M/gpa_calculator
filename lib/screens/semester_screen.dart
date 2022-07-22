import 'package:flutter/material.dart';

import '../models/semester.dart';

import '../widgets/module_list_tile.dart';

class SemesterScreen extends StatelessWidget {
  final Semester semester;
  const SemesterScreen({Key? key, required this.semester}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Semester ${semester.semester}"),),
      body: semester.modules.isNotEmpty? Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: semester.modules.length,
              itemBuilder: (context, index) {
                return ModuleListTile(module: semester.modules[index],);
              },
            ),
          ),
        ],
      ) :
      const Center(child: Text("No Modules found for this semester"),),
    );
  }
}
