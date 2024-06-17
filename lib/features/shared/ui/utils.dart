import 'package:chuck_interceptor/chuck.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nutrobo/core/di.dart';


AppBar buildAppBar(BuildContext context) {
  return AppBar(
      title: const Text(
          "Diabetes Friend",
          style: TextStyle(color: Colors.white)
      ),
      backgroundColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      actions: [
        if (kDebugMode)
          IconButton(
            icon: const Icon(Icons.http),
            onPressed: () {
              getIt.get<Chuck>().showInspector();
            }
          )
      ]);
}