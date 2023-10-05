import 'package:flutter/material.dart';
import 'package:todo_app_assignment/utilities/colors.dart';

class Button extends StatefulWidget {
  const Button({super.key, required this.onPressed, required this.title});

  final String title;
  final VoidCallback onPressed;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.grey.shade300),
            backgroundColor: MaterialStatePropertyAll(bgColor)),
        child: Text(widget.title),
      ),
    );
  }
}
