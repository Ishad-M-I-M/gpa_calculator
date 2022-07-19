import 'package:flutter/material.dart';

import '../models/semester.dart';

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
                return ListTile(
                  title: Text('${semester.modules[index].code} ${semester.modules[index].name}'),
                  subtitle: Text('credits: ${semester.modules[index].credits}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle_outline_sharp),
                    onPressed: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ) :
      const Center(child: Text("No Modules found for this semester"),),
    );
  }
}
