import 'package:flutter/material.dart';
import 'package:todo_app_assignment/screens/home.dart';
import 'package:todo_app_assignment/utilities/colors.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        appBarTheme: AppBarTheme(color: bgColor),
      ),
      home: const HomeScreen(),
    );
  }
}
