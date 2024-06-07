import 'package:flutter/material.dart';
import 'package:nutrobo/core/routes.dart';


AppBar buildAppBar(BuildContext context, {bool showSettings = false}) {
  return AppBar(
      title: const Text(
          "Diabetes Friend",
          style: TextStyle(color: Colors.white)
      ),
      backgroundColor: const Color(0xFF007AFF),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        if (showSettings)
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push(
                Routes.toSettings(context)
              );
            }
          )
      ]);
}