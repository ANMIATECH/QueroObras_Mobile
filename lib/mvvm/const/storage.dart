// lib/services/storage_service.dart

import '../const/export.dart';

class StorageService {
  static final GetStorage _storage = GetStorage();

  // Initialize storage
  static Future<void> init() async {
    await GetStorage.init();
  }

  // Save data
  static Future<void> write(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  // Read data
  static T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  // Remove a key
  static Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  // Clear all storage
  static Future<void> clear() async {
    await _storage.erase();
  }

  // Check if key exists
  static bool has(String key) {
    return _storage.hasData(key);
  }
}
