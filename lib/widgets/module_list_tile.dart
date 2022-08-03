import 'package:flutter/material.dart';

import '../db/SQLHelper.dart';

import '../models/module.dart';
import '../widgets/add_result_alert_dialog.dart';

class ModuleListTile extends StatelessWidget {
  final Module module;

  const ModuleListTile({required this.module, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      title: Text('${module.code} | ${module.name}', style: Theme.of(context).textTheme.titleMedium,),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Credits: ${module.credits}', style: Theme.of(context).textTheme.bodySmall,),
          Text('Grade: ${module.result}', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        color: Colors.red,
        onPressed: (){
          SQLHelper.deleteModule(module.id);
        }
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return AddResultAlertDialog(
                module: module,
                update: (updatedModule) {
                  SQLHelper.updateModule(updatedModule);
                }
              );
            });
      },
    );
  }
}
