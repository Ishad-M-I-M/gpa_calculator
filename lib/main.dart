import 'package:flutter/material.dart';

import './screens/home_screen.dart';

void main() => runApp(const GPACalculatorApp());

class GPACalculatorApp extends StatelessWidget {
  const GPACalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Text Calculator",
      home: const HomeScreen(),

      // Theme data
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),

        // Text theme
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),

        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
        ),

      ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade900,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color: Colors.grey.shade900,
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        // Theme for alert Dialog Box
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          titleTextStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          contentTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          backgroundColor: Colors.grey.shade900,
        ),

        // Text Theme
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),

        // Theme for bottom sheet
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.grey.shade900,
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
            ),
          ),
        ),

      ),

    );
  }
}
