import 'package:flutter/material.dart';


AppBar buildAppBar(BuildContext context, {bool showSettings = false}) {
  return AppBar(
      title: const Text(
          "Diabetes Friend",
          style: TextStyle(color: Colors.white)
      ),
      backgroundColor: const Color(0xFF007AFF),
      iconTheme: const IconThemeData(color: Colors.white)
  );
}