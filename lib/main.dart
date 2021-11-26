import 'package:flutter/material.dart';
import 'package:task_creator/app_theme.dart';
import 'package:task_creator/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDark ? AppTheme.dark() : AppTheme.light(),
      home: Home(
        onPressed: changeTheme,
        isDark: _isDark,
      ),
    );
  }

  void changeTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }
}
