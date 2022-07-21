import 'package:flutter/material.dart';

import '../models/module.dart';

import '../widgets/add_result_alert_dialog.dart';

class ModuleListTile extends StatelessWidget {
  final Module module;
  const ModuleListTile({required this.module,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      title: Text('${module.code} | ${module.name}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Credits: ${module.credits}'),
          Text('Grade: ${module.result}'),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.add_circle_outline_sharp),
        onPressed: () {
          showDialog(context: context, builder: (_){
            return AddResultAlertDialog(module: module,);
          });
        },
      ),
    );
  }
}
