import 'package:nutrobo/core/environment.dart';
import 'package:nutrobo/features/auth/service/auth_service.dart';
import 'package:nutrobo/features/shared/bloc/base_bloc.dart';
import 'package:nutrobo/features/shared/bloc/states.dart';
import 'package:nutrobo/features/shared/service/storage_service.dart';

class SettingsSuccessState extends SuccessState {
  final List<String> environments;
  final String currentEnvironment;
  final String authToken;
  SettingsSuccessState({
    required this.environments,
    required this.currentEnvironment,
    required this.authToken,
  });
}

class SettingsBloc extends BaseBloc {

  final StorageService storage;
  final AuthService auth;
  final Environments environments;

  SettingsBloc({
    required this.storage,
    required this.environments,
    required this.auth,
  }) : super(LoadingState()) {

    on<UpdateEvent>((event, emit) async {
      emit(SettingsSuccessState(
          environments: environments.environments.map((e) => e.name).toList(),
          currentEnvironment: (await storage.currentEnvironment).name,
          authToken: await auth.getToken(),
      ));
    });

    add(UpdateEvent());
  }

  Future<void> selectEnvironment(String name) async {
    await storage.updateEnvironment(name);
    add(UpdateEvent());
  }

}
