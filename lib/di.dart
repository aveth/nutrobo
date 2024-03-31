import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrobo/environment.dart';
import 'package:nutrobo/features/chat/bloc/gpt_sdk.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerSingleton(const Environment(
      gptApiKey: String.fromEnvironment("GPT_API_KEY"),
      usdaApiKey: String.fromEnvironment("USDA_API_KEY"),
      gptOrgId: String.fromEnvironment("GPT_ORG_ID"),
  ));
  getIt.registerSingleton(FlutterSecureStorage());
  getIt.registerFactory(() => GptSdk(
      environment: getIt.get<Environment>()
  ));
}