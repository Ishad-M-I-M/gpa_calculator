import 'package:flutter/material.dart';

import '../widgets/gpa_vlaues_list.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<bool> _isOpen = [false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionPanelList(
              children: [
                ExpansionPanel(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                    headerBuilder: (context, isOpen) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("GPA values", style: Theme.of(context).textTheme.bodyMedium),
                      );
                    },
                    body: const GPAValueList(),
                    isExpanded: _isOpen[0])
              ],
              expansionCallback: (i, isOpen) {
                setState(() => {_isOpen[i] = !isOpen});
              },
            )
          ],
        ),
      ),
    );
  }
}
