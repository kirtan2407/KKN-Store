import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  static final TLocalStorage _instance = TLocalStorage._internal();
  factory TLocalStorage() => _instance;

  final GetStorage _storage = GetStorage();

  TLocalStorage._internal();

  /// Save data of any type
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  /// Read data of any type
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  /// Remove data by key
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  /// Clear all stored data
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
