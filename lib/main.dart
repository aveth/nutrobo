import 'package:chuck_interceptor/chuck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/core/di.dart';
import 'package:nutrobo/core/theme.dart';
import 'package:nutrobo/features/auth/bloc/auth_bloc.dart';
import 'package:nutrobo/features/auth/ui/auth_screen.dart';
import 'package:nutrobo/features/barcode/bloc/barcode_bloc.dart';
import 'package:nutrobo/features/chat/bloc/chat_bloc.dart';
import 'package:nutrobo/features/home/bloc/home_bloc.dart';
import 'package:nutrobo/features/meals/bloc/meals_bloc.dart';
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
      navigatorKey: getIt.get<Chuck>().getNavigatorKey(),
      debugShowCheckedModeBanner: false,
      theme: nutroboTheme(),
      home: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => getIt.get<ChatBloc>(),
        ),
        BlocProvider(
            create: (context) => getIt.get<AuthBloc>()
        ),
        BlocProvider(
            create: (context) => getIt.get<SettingsBloc>()
        ),
        BlocProvider(
            create: (context) => getIt.get<HomeBloc>()
        ),
        BlocProvider(
            create: (context) => getIt.get<MealsBloc>()
        ),
        BlocProvider(
            create: (context) => getIt.get<BarcodeBloc>()
        )
      ], child: const AuthScreen()),
    );
  }
}
