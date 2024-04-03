import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/core/di.dart';
import 'package:nutrobo/features/chat/bloc/chat_bloc.dart';

import 'features/chat/ui/chat_screen.dart';

void main() async {
  await setupDependencyInjection();
  runApp(const NutroboApp());
}

class NutroboApp extends StatelessWidget {
  const NutroboApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrobo: Your AI Nutrition Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (BuildContext context) => getIt.get<ChatBloc>(),
        ),
      ], child: ChatScreen()),
    );
  }
}