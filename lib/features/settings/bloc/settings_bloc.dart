import 'package:bloc/bloc.dart';
import 'package:nutrobo/core/environment.dart';
import 'package:nutrobo/features/auth/service/auth_service.dart';
import 'package:nutrobo/features/shared/service/storage_service.dart';

abstract class _SettingsEvent { }
abstract class SettingsState { }

class _InitialEvent extends _SettingsEvent { }

class InitialState extends SettingsState { }
class LoadedState extends SettingsState {
  final List<String> environments;
  final String currentEnvironment;
  final String authToken;
  LoadedState({
    required this.environments,
    required this.currentEnvironment,
    required this.authToken,
  });
}

class SettingsBloc extends Bloc<_SettingsEvent, SettingsState> {

  final StorageService storage;
  final AuthService auth;
  final Environments environments;

  SettingsBloc({
    required this.storage,
    required this.environments,
    required this.auth,
  }) : super(InitialState()) {

    on<_InitialEvent>((event, emit) async {
      emit(LoadedState(
          environments: environments.environments.map((e) => e.name).toList(),
          currentEnvironment: (await storage.currentEnvironment).name,
          authToken: await auth.getToken(),
      ));
    });

    add(_InitialEvent());
  }

  Future<void> selectEnvironment(String name) async {
    await storage.updateEnvironment(name);
    add(_InitialEvent());
  }

}
