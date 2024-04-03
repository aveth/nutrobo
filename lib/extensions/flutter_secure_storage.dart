import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _threadIdKey = "THREAD_ID";

extension StorageHelpers on FlutterSecureStorage {
  void setThreadId(String id) => write(key: _threadIdKey, value: id);
  Future<String?> getThreadId() => read(key: _threadIdKey);
}