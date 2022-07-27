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
      body: Column(
        children: [
          ExpansionPanelList(
            children: [
              ExpansionPanel(
                  headerBuilder: (context, isOpen) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("GPA values", style: TextStyle(fontSize: 18)),
                    );
                  },
                  body: GPAValueList(),
                  isExpanded: _isOpen[0])
            ],
            expansionCallback: (i, isOpen) {
              setState(() => {_isOpen[i] = !isOpen});
            },
          )
        ],
      ),
    );
  }
}
