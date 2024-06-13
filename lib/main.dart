import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/core/di.dart';
import 'package:nutrobo/features/auth/bloc/auth_bloc.dart';
import 'package:nutrobo/features/auth/ui/auth_screen.dart';
import 'package:nutrobo/features/barcode/bloc/barcode_bloc.dart';
import 'package:nutrobo/features/chat/bloc/chat_bloc.dart';
import 'package:nutrobo/features/home/bloc/home_bloc.dart';
import 'package:nutrobo/features/settings/bloc/settings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencyInjection();
  runApp(const NutroboApp());
}

class NutroboApp extends StatelessWidget {
  const NutroboApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabetes Friend',
      navigatorKey: getIt.get<Alice>().getNavigatorKey(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => getIt.get<ChatBloc>(),
        ),
        BlocProvider(
            create: (context) => getIt.get<BarcodeBloc>(),
        ),
        BlocProvider(
            create: (context) => getIt.get<AuthBloc>()
        ),
        BlocProvider(
            create: (context) => getIt.get<SettingsBloc>()
        ),
        BlocProvider(
            create: (context) => getIt.get<HomeBloc>()
        )
      ], child: const AuthScreen()),
    );
  }
}
