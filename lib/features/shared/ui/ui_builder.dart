import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/features/shared/bloc/base_bloc.dart';
import 'package:nutrobo/features/shared/bloc/states.dart';

class UiBuilder<B extends BaseBloc> extends StatelessWidget {

  final BlocWidgetBuilder<UiState> builder;

  const UiBuilder(this.builder, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, UiState>(
        bloc: context.watch<B>(),
        builder: builder
    );
  }



}