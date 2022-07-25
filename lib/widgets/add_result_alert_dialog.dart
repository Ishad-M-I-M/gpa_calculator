import 'package:flutter/material.dart';

import '../models/module.dart';

import '../config/constants.dart';

class AddResultAlertDialog extends StatefulWidget {
  final Module module;
  final Function update;
  const AddResultAlertDialog({required this.module, required this.update, Key? key}) : super(key: key);

  @override
  State<AddResultAlertDialog> createState() => _AddResultAlertDialogState();
}

class _AddResultAlertDialogState extends State<AddResultAlertDialog> {
  List<String> results = gpaValues.keys.toList();
  var result = TextEditingController();
  bool isValid = true;

  void submitResult() async{
    if(! results.contains(result.text.trim())){
      setState(() {
        isValid = false;
      });
    }
    else{
      Module moduleUpdated = widget.module;
      moduleUpdated.result = result.text.trim();
      widget.update(moduleUpdated);
      Navigator.of(context).pop();
    }
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Result"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(label: Text("Enter Result For ${widget.module.code}")),
            keyboardType: TextInputType.text,
            controller: result,
          ),
          if (!isValid)
            const Text("Not a valid result"),
        ],
      ),
      actions: [
        TextButton(onPressed: submitResult, child: const Text("Add")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")),
      ],
    );

  }
}
