import 'package:flutter/material.dart';

import './screens/home_screen.dart';

void main() => runApp(const GPACalculatorApp());

class GPACalculatorApp extends StatelessWidget {
  const GPACalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Text Calculator",
      home: HomeScreen(),
    );
  }
}
