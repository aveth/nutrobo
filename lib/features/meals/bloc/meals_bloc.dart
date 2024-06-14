import 'package:nutrobo/features/chat/service/nutrobo_api.dart';
import 'package:nutrobo/features/shared/bloc/base_bloc.dart';
import 'package:nutrobo/features/shared/bloc/states.dart';

class MealsSuccessState extends SuccessState { }

class MealsBloc extends BaseBloc {

  final NutroboApi api;

  MealsBloc({required this.api}) : super(LoadingState()) {

    on<InitEvent>((event, emit) {
      emit(MealsSuccessState());
    });

    add(InitEvent());
  }



}