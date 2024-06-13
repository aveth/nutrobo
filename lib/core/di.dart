import 'package:alice/alice.dart';
import 'package:chopper/chopper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:nutrobo/core/environment.dart';
import 'package:nutrobo/core/model_converter.dart';
import 'package:nutrobo/features/auth/bloc/auth_bloc.dart';
import 'package:nutrobo/features/auth/service/auth_interceptor.dart';
import 'package:nutrobo/features/auth/service/auth_service.dart';
import 'package:nutrobo/features/barcode/bloc/barcode_bloc.dart';
import 'package:nutrobo/features/chat/bloc/chat_bloc.dart';
import 'package:nutrobo/features/chat/model/thread.dart';
import 'package:nutrobo/features/chat/service/nutrobo_api.dart';
import 'package:nutrobo/features/home/bloc/home_bloc.dart';
import 'package:nutrobo/features/profile/model/profile.dart';
import 'package:nutrobo/features/settings/bloc/settings_bloc.dart';
import 'package:nutrobo/features/shared/service/storage_service.dart';
import 'package:nutrobo/firebase_options.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {

  await dotenv.load(fileName: ".env");
  await _firebase();

  _logger();
  _storage();
  _environment();
  _services();
  await _chopper();
  _viewModels();
}

Future<void> _firebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
}

void _logger() {
  Logger.root.onRecord.listen((rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

void _storage() {
  getIt.registerSingleton(const FlutterSecureStorage());
}

void _environment() {
  getIt.registerSingleton(Environments(environments: [
    Environment(
        name: 'prod',
        nutroboBaseUrl: dotenv.env["NUTROBO_BASE_URL_PROD"] ?? ""
    ),
    Environment(
        name: 'dev',
        nutroboBaseUrl: dotenv.env['NUTROBO_BASE_URL_DEV'] ?? ""
    ),
  ]));
}

Future<void> _chopper() async {
  final chopper = ChopperClient(
    baseUrl: Uri.parse(
        (await getIt.get<StorageService>().currentEnvironment).nutroboBaseUrl
    ),
    services: [
      NutroboApi.create()
    ],
    interceptors: [
      HttpLoggingInterceptor(),
      AuthInterceptor(auth: getIt.get<AuthService>()),
      getIt.get<Alice>().getChopperInterceptor()
    ],
    errorConverter: const JsonConverter(),
    converter: ModelConverter({
      Thread: (json) => Thread.fromJson(json),
      Profile: (json) => Profile.fromJson(json)
    }),
  );

  getIt.registerSingleton(chopper);
}

void _services() {
  getIt.registerSingleton(AuthService(
      auth: FirebaseAuth.instance
  ));
  getIt.registerSingleton(Alice(
      showNotification: true,
      showInspectorOnShake: true,
      maxCallsCount: 1000,
  ));
  getIt.registerSingleton(StorageService(
      storage: getIt.get<FlutterSecureStorage>(),
      environments: getIt.get<Environments>()
  ));
}

void _viewModels() {
  getIt.registerSingleton(ChatBloc(
      auth: getIt.get<AuthService>(),
      api: getIt.get<ChopperClient>().getService<NutroboApi>()
  ));

  getIt.registerSingleton(BarcodeBloc(
      storage: getIt.get<FlutterSecureStorage>(),
      api: getIt.get<ChopperClient>().getService<NutroboApi>()
  ));

  getIt.registerSingleton(AuthBloc(
      auth: getIt.get<AuthService>()
  ));

  getIt.registerSingleton(SettingsBloc(
      storage: getIt.get<StorageService>(),
      environments: getIt.get<Environments>(),
      auth: getIt.get<AuthService>()
  ));

  getIt.registerSingleton(HomeBloc());
}