import 'package:flutter/material.dart';
import 'package:nutrobo/features/meals/bloc/meals_bloc.dart';
import 'package:nutrobo/features/meals/ui/add_meal_dialog.dart';
import 'package:nutrobo/features/shared/ui/loading_indicator.dart';
import 'package:nutrobo/features/shared/ui/ui_builder.dart';

class MealsScreen extends StatelessWidget {

  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UiBuilder<MealsBloc>((context, state) {
      switch (state.runtimeType) {
        case MealsSuccessState:
          state as MealsSuccessState;
          return FloatingActionButton(onPressed: () {
            showDialog(context: context, builder: (context) => AddMealDialog());
          });
        default:
          return const LoadingIndicator();
      }
    });
  }

}
