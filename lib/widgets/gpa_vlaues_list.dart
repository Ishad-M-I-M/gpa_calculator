import 'package:flutter/material.dart';

import '../db/SQLHelper.dart';
import '../models/result.dart';

class GPAValueList extends StatefulWidget {
  const GPAValueList({Key? key}) : super(key: key);

  @override
  State<GPAValueList> createState() => _GPAValueListState();
}

class _GPAValueListState extends State<GPAValueList> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FutureBuilder<List<Result>>(
        initialData: const [],
        future: SQLHelper.getGPAs(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          return Column(
            children: [
              ...(snapshot.data as List<Result>).map((e) => Padding(
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
          );
        }
      ),
    );
  }
}
