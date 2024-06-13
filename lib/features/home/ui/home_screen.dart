import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/features/home/bloc/home_bloc.dart';
import 'package:nutrobo/features/shared/ui/loading_indicator.dart';
import 'package:nutrobo/features/shared/ui/top_bar.dart';
import 'package:nutrobo/features/shared/ui/ui_builder.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context, showSettings: true),
      body: UiBuilder<HomeBloc>((context, state) {
        switch (state.runtimeType) {
          case HomeSuccessState:
            state as HomeSuccessState;
            return state.currentScreen;
          default:
            return const LoadingIndicator();
        }
      }),
      bottomNavigationBar: UiBuilder<HomeBloc>((context, state) {
        switch (state.runtimeType) {
          case HomeSuccessState:
            state as HomeSuccessState;
            return BottomNavigationBar(
              currentIndex: state.currentTabIndex,
              onTap: (index) => context.read<HomeBloc>().switchTab(index),
              items: List.generate(state.items.length, (index) => state.items[index]),
            );
          default:
            return Container();
        }
      }),
    );
  }

}