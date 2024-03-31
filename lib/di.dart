import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrobo/environment.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerSingleton(const Environment(
      gptApiKey: String.fromEnvironment("GPT_API_KEY"),
      usdaApiKey: String.fromEnvironment("USDA_API_KEY")
  ));
  getIt.registerSingleton(FlutterSecureStorage());
}