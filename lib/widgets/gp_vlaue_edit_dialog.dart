import 'package:flutter/material.dart';

class GPValueEditDialog extends StatefulWidget {
  final String grade;
  const GPValueEditDialog(this.grade, {Key? key}) : super(key: key);

  @override
  State<GPValueEditDialog> createState() => _GPValueEditDialogState();
}

class _GPValueEditDialogState extends State<GPValueEditDialog> {
  final TextEditingController _gpValueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Grade Point Value"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "New Grade Point Value for ${widget.grade}",
              hintText: "e.g. 4.0",
            ),
            controller: _gpValueController,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Save"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
