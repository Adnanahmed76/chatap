import 'package:flutter/material.dart';

class SettingSreen extends StatelessWidget {
  const SettingSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("settings"),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
