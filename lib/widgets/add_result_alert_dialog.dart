import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/module.dart';

import '../bloc/add_result/add_result_bloc.dart';

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

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> AddResultBloc(),
      child: BlocBuilder<AddResultBloc, AddResultState>(
        builder: (context, state) {
          Widget content;
          if(state is Initial){
            content = const CircularProgressIndicator();
            context.read<AddResultBloc>().add(const MountEvent());
          }
          else if (state is Loaded){
            content =
                  DropdownButtonFormField(
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
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
                    items: state.results.map((e) => DropdownMenuItem(
                      value: e.result,
                      child: Text(e.result),
                    )).toList(),
                    hint: Text("Select Result", style: Theme.of(context).textTheme.bodyMedium,),
                    value: selectedResult == ""?null: selectedResult,
                  );
          }
          else if (state is Submitted){
            content = const CircularProgressIndicator();
          }
          else if (state is Saved){
            content = const CircularProgressIndicator();
            Navigator.of(context).pop();
          }
          else if (state is Error){
            content = Text("Error: ${state.message}");
          }
          else{
            content = Center(child: Text("Error: ${state.toString()}"));
          }
          return AlertDialog(
            title: const Text("Add Result"),
            content: content,
            actions: [
              TextButton(
                onPressed:(){
                  context.read<AddResultBloc>().add(SubmitEvent(module: widget.module ,result: selectedResult));
                },
                child: const Text("Add")
            ),
              TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel")),
            ],
          );
        },

      )
    );
  }
}

