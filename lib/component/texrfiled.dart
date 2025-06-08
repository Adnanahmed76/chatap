import 'package:flutter/material.dart';

class MyTextfiled extends StatelessWidget {
  final String hintext;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextfiled(
      {super.key,
      required this.hintext,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary)),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintText: hintext,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
      ),
    );
  }
}
