import 'package:bloc/bloc.dart';
import 'package:nutrobo/features/shared/bloc/states.dart';

abstract class BaseBloc extends Bloc<UiEvent, UiState> {
  BaseBloc(super.initialState);
}