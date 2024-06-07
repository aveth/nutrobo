import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutrobo/core/environment.dart';

class StorageService {

  final FlutterSecureStorage storage;
  final Environments environments;

  final _envKey = 'CURRENT_ENV';

  StorageService({
    required this.storage,
    required this.environments
  });

  Future<Environment> get currentEnvironment async {
    var name = await storage.read(key: _envKey) ?? 'dev';
    return environments.get(name);
  }

  Future<void> updateEnvironment(String name) async {
    await storage.write(key: _envKey, value: name);
  }

}