import 'package:bloc/bloc.dart';


class BoolCubit extends Cubit<bool> {
  BoolCubit(super.initialState);
  void update(bool newValue) => emit(newValue);
}