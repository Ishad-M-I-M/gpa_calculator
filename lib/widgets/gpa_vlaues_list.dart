import 'package:flutter/material.dart';

import '../db/SQLHelper.dart';
import '../models/result.dart';

class GPAValueList extends StatefulWidget {
  const GPAValueList({Key? key}) : super(key: key);

  @override
  State<GPAValueList> createState() => _GPAValueListState();
}

class _GPAValueListState extends State<GPAValueList> {
  List<Result> gpas = [];

  void loadGPAs() async {
    List<Result> gpas_ = await SQLHelper.getGPAs();
    setState(() {
      gpas = gpas_;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadGPAs();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          ...gpas.map((e) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(e.result),
                Text(e.gpa.toString())
              ],
            ),
          ))
        ],
      ),
    );
  }
}
