import 'package:chopper/chopper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:nutrobo/core/environment.dart';
import 'package:nutrobo/core/model_converter.dart';
import 'package:nutrobo/features/chat/bloc/chat_bloc.dart';
import 'package:nutrobo/features/chat/model/thread.dart';
import 'package:nutrobo/features/chat/service/nutrobo_api.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {

  await dotenv.load(fileName: ".env");

  _logger();
  _storage();
  _environment();
  _chopper();
  _viewModels();
}

void _logger() {
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

void _storage() {
  getIt.registerSingleton(const FlutterSecureStorage());
}

void _environment() {
  var env = Environment(
    nutroboApiKey: dotenv.env["NUTROBO_API_KEY"] ?? ""
  );

  getIt.registerSingleton(env);
}

void _chopper() {
  final chopper = ChopperClient(
    baseUrl: Uri.parse(
        dotenv.env["NUTROBO_BASE_URL"] ?? ""
    ),
    services: [
      NutroboApi.create()
    ],
    interceptors: [
      HttpLoggingInterceptor()
    ],
    errorConverter: const JsonConverter(),
    converter: ModelConverter({
      Thread: (json) => Thread.fromJson(json)
    }),
  );

  getIt.registerSingleton(chopper);
}

void _viewModels() {
  getIt.registerFactory(() => ChatBloc(
      storage: getIt.get<FlutterSecureStorage>(),
      api: getIt.get<ChopperClient>().getService<NutroboApi>()
  ));
}