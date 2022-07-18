import 'package:flutter/material.dart';

class AddModule extends StatefulWidget {
  const AddModule({Key? key}) : super(key: key);

  @override
  State<AddModule> createState() => _AddModuleState();
}

class _AddModuleState extends State<AddModule> {
  @override
  Widget build(BuildContext context) {
    var moduleCode = TextEditingController();
    var moduleName = TextEditingController();
    var moduleCredits = TextEditingController();
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
            decoration: const InputDecoration(label: Text("Enter module credits")),
            keyboardType: TextInputType.number,
          ),
          TextButton(onPressed: (){}, child: const Text("Add Module"))
        ],
      ),
    );
  }
}
