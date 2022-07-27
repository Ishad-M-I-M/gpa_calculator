import 'package:flutter/material.dart';

import '../db/SQLHelper.dart';
import '../models/result.dart';

import '../widgets/gp_vlaue_edit_dialog.dart';

class GPValueList extends StatefulWidget {
  const GPValueList({Key? key}) : super(key: key);

  @override
  State<GPValueList> createState() => _GPValueListState();
}

class _GPValueListState extends State<GPValueList> {
  List<Result> gpas = [];

  void loadGPAs() async {
    List<Result> gpas_ = await SQLHelper.getGPAs();
    setState(() {
      gpas = gpas_;
    });
  }

  void displayGPValueEditDialog(BuildContext context, Result gp) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => GPValueEditDialog(gp.result)));
  }

  @override
  Widget build(BuildContext context) {
    loadGPAs();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          ...gpas.map((e) => InkWell(
            onTap: ()=> displayGPValueEditDialog(context, e),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(e.result),
                  Text(e.gpa.toString())
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
