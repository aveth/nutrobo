import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/features/auth/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Your Diabetes Friend"),
          backgroundColor: const Color(0xFF007AFF),
        ),
        body: Center(
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: () => context.read<AuthBloc>().performLogin())
            ],
          ),
        ));
  }
}