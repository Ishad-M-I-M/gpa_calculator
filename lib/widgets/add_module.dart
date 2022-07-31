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
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 6, right: 6),
      child: Column(
        children: [
          const Text("Module Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextFormField(
            controller: moduleCode,
            decoration: InputDecoration(label: const Text("Enter Module Code"), border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0))),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: moduleName,
            decoration: InputDecoration(label: const Text("Enter Module Name"), border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0))),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: moduleCredits,
            decoration:
                InputDecoration(label: const Text("Enter module credits"), border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0))),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
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
