import 'package:flutter/material.dart';

import '../models/module.dart';
import '../widgets/add_result_alert_dialog.dart';

class ModuleListTile extends StatelessWidget {
  final Module module;
  final Function delete;

  const ModuleListTile({required this.module, required this.delete, Key? key}) : super(key: key);

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
        icon: const Icon(Icons.delete),
        color: Colors.red,
        onPressed: ()=> delete(module.id)
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return AddResultAlertDialog(
                module: module,
              );
            });
      },
    );
  }
}
