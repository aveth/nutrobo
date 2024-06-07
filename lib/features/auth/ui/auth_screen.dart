import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/features/auth/bloc/auth_bloc.dart';
import 'package:nutrobo/features/auth/ui/login_screen.dart';
import 'package:nutrobo/features/chat/ui/chat_screen.dart';
import 'package:nutrobo/features/shared/ui/loading_indicator.dart';
import 'package:nutrobo/features/shared/ui/top_bar.dart';

class AuthScreen extends StatelessWidget {

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: context.watch<AuthBloc>(),
        builder: (context, state) {
          switch (state) {
            case LoggedInState _:
              return ChatScreen();
            case LoggedOutState _:
              return const LoginScreen();
            default:
              return Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: buildAppBar(context, showSettings: true),
                body: const LoadingIndicator()
              );
          }
        });
  }
}