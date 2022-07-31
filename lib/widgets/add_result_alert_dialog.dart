import 'package:flutter/material.dart';

import '../db/SQLHelper.dart';
import '../models/module.dart';

import '../models/result.dart';

class AddResultAlertDialog extends StatefulWidget {
  final Module module;
  final Function update;
  const AddResultAlertDialog({required this.module, required this.update, Key? key}) : super(key: key);

  @override
  State<AddResultAlertDialog> createState() => _AddResultAlertDialogState();
}

class _AddResultAlertDialogState extends State<AddResultAlertDialog> {
  String selectedResult = "";

  void submitResult() async{
      Module moduleUpdated = widget.module;
      moduleUpdated.result = selectedResult.toString().trim();
      widget.update(moduleUpdated);
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Result"),
      content: FutureBuilder<List<Result>>(
        initialData: const [],
        future: SQLHelper.getGPAs(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          return
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedResult = value.toString();
                });
              },
              items: snapshot.data?.map((e) => DropdownMenuItem(
                value: e.result,
                child: Text(e.result),
              )).toList(),
              hint: const Text("Select Result"),
              value: selectedResult == ""?null: selectedResult,
            );
        },
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
