import 'package:nutrobo/features/auth/service/auth_service.dart';
import 'package:nutrobo/features/shared/bloc/base_bloc.dart';
import 'package:nutrobo/features/shared/bloc/states.dart';

class AuthBloc extends BaseBloc {

  final AuthService auth;

  AuthBloc({
    required this.auth
  }) : super(LoadingState()) {

    on<InitEvent>((event, emit) async {
      await _updateState(emit);
      auth.loggedInStream.listen((event) async {
        await _updateState(emit);
      });
    });

    on<UpdateEvent>((event, emit) async {
      await _updateState(emit);
    });

    add(InitEvent());
  }

  void performLogin() async {
    await auth.signInWithGoogle();
    add(UpdateEvent());
  }

  Future<void> _updateState(emit) async {
    if (!auth.isLoggedIn) {
      emit(FailureState());
    } else {
      var token = await auth.getToken();
      if (token.isNotEmpty) {
        emit(SuccessState());
      } else {
        emit(FailureState());
      }
    }
  }

}
