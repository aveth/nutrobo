import 'package:bloc/bloc.dart';

class BasicCubit<T> extends Cubit<T> {

  BasicCubit(super.initialValue);

  void updateValue(T newValue) {
    emit(newValue);
  }
}

extension CubitStringX on String {
  BasicCubit<String> toCubit() => BasicCubit("");
}

extension CubitBoolX on bool {
  BasicCubit<bool> toCubit() => BasicCubit(false);
}

extension CubitIntX on int {
  BasicCubit<int> toCubit() => BasicCubit(0);
}