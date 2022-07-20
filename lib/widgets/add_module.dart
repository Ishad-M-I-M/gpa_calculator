import 'dart:async';

import 'package:flutter/material.dart';

import '../models/module.dart';

class AddModule extends StatefulWidget {
  final Function addModule;
  final int semester;
  const AddModule({required this.semester, required this.addModule, Key? key}) : super(key: key);

  @override
  State<AddModule> createState() => _AddModuleState();
}

class _AddModuleState extends State<AddModule> {
  var moduleCode = TextEditingController();
  var moduleName = TextEditingController();
  var moduleCredits = TextEditingController();

  Future<void> insertModule() async {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 6, right: 6),
      child: Column(
        children: [
          TextFormField(
            controller: moduleCode,
            decoration: const InputDecoration(label: Text("Enter Module Code")),
          ),
          TextFormField(
            controller: moduleName,
            decoration: const InputDecoration(label: Text("Enter Module Name")),
          ),
          TextFormField(
            controller: moduleCredits,
            decoration:
                const InputDecoration(label: Text("Enter module credits")),
            keyboardType: TextInputType.number,
          ),
          TextButton(
              onPressed: () {
                widget.addModule(Module(
                    code: moduleCode.text,
                    name: moduleName.text,
                    credits: double.parse(moduleCredits.text),
                    semester: widget.semester));
                Navigator.of(context).pop();
              },
              child: const Text("Add Module"))
        ],
      ),
    );
  }
}
