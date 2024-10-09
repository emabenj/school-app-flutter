import 'package:get_storage/get_storage.dart';

class BLocalStorage {
  static final BLocalStorage _instance = BLocalStorage._internal();

  factory BLocalStorage() {
    return _instance;
  }

  BLocalStorage._internal();

  final _storage = GetStorage();

  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> removeData<T>(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll<T>() async {
    await _storage.erase();
  }
}
