import 'package:bloc/bloc.dart';
import 'package:nutrobo/features/auth/service/auth_service.dart';

abstract class _AuthEvent { }
abstract class AuthState { }

class _InitialEvent extends _AuthEvent { }
class _LoginEvent extends _AuthEvent {
  _LoginEvent();
}
class _LogoutEvent extends _AuthEvent { }

class InitialState extends AuthState { }
class LoggedInState extends AuthState {
  final String authToken;
  LoggedInState({required this.authToken});
}
class LoggedOutState extends AuthState { }


class AuthBloc extends Bloc<_AuthEvent, AuthState> {

  final AuthService auth;

  AuthBloc({
    required this.auth
  }) : super(InitialState()) {

    on<_InitialEvent>((event, emit) async {
      auth.loggedInStream.listen((event) async {
        await _updateState(emit);
      });
    });

    on<_LoginEvent>((event, emit) async {
      await _updateState(emit);
    });

    add(_InitialEvent());
  }

  Future<void> performLogin() async {
    final success = await auth.signInWithGoogle();

    if (success) {
      add(_LoginEvent());
    }
  }

  void performLogout() {
    add(_LogoutEvent());
  }

  Future<void> _updateState(emit) async {
    if (!auth.isLoggedIn) {
      emit(LoggedOutState());
    } else {
      var token = await auth.getToken();
      if (token.isEmpty) {
        emit(LoggedOutState());
      } else {
        emit(LoggedInState(authToken: token));
      }
    }
  }

}
