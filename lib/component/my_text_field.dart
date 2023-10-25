import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.controller, required this.hint});
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: CupertinoColors.white,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint
        ),
      ),
    );
  }
}
