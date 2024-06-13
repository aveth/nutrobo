import 'package:flutter/material.dart';
import 'package:nutrobo/features/auth/bloc/auth_bloc.dart';
import 'package:nutrobo/features/auth/ui/login_screen.dart';
import 'package:nutrobo/features/home/ui/home_screen.dart';
import 'package:nutrobo/features/shared/bloc/states.dart';
import 'package:nutrobo/features/shared/ui/loading_indicator.dart';
import 'package:nutrobo/features/shared/ui/ui_builder.dart';

class AuthScreen extends StatelessWidget {

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UiBuilder<AuthBloc>((context, state) {
      switch (state.runtimeType) {
        case SuccessState:
          return const HomeScreen();
        case FailureState:
          return const LoginScreen();
        default:
          return const LoadingIndicator();
      }
    });
  }
}