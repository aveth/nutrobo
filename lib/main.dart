import 'package:flutter/material.dart';
import 'package:nutrobo/di.dart';
import 'package:provider/provider.dart';

import 'chat_controller.dart';
import 'chat_screen.dart';

void main() {
  setupDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat UI Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => ChatController(),
        child: const ChatScreen(),
      ),
    );
  }
}