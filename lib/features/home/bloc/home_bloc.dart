import 'package:flutter/material.dart';
import 'package:nutrobo/features/chat/ui/chat_screen.dart';
import 'package:nutrobo/features/shared/bloc/base_bloc.dart';
import 'package:nutrobo/features/shared/bloc/states.dart';
import 'package:nutrobo/features/shared/ui/loading_indicator.dart';

class HomeSuccessState extends SuccessState {

  final Widget currentScreen;
  final int currentTabIndex;
  final List<BottomNavigationBarItem> items;

  HomeSuccessState({
    required this.currentScreen,
    required this.currentTabIndex,
    required this.items
  });
}

class HomeBloc extends BaseBloc {

  var _currentTabIndex = 0;

  final _screens = [
    ChatScreen(),
    const LoadingIndicator(),
  ];

  final _items = [
    const BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
    const BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Meals")
  ];

  HomeBloc() : super(LoadingState()) {

    on<UpdateEvent>((event, emit) {
      emit(
          HomeSuccessState(
              currentScreen: _screens[_currentTabIndex],
              currentTabIndex: _currentTabIndex,
              items: _items
          )
      );
    });

    add(UpdateEvent());
  }

  void switchTab(int newIndex) {
    if (newIndex >= _screens.length || newIndex < 0) {
      _currentTabIndex = 0;
    } else {
      _currentTabIndex = newIndex;
    }

    add(UpdateEvent());
  }

}