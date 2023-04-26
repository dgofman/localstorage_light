class LocalStorage implements LocalStorageInterface {

  static Future<LocalStorage> init(String fileName) async {
    throw Exception();
  }

  @override
  dynamic getItem(String key) {
    throw Exception();
  }
  @override
  Future<void> clear() {
    throw Exception();
  }
  @override
  Future<void> flush() {
    throw Exception();
  }
  @override
  Future<void> setItem(String key, dynamic value) {
    throw Exception();
  }
  @override
  Future<void> removeItem(String key) {
    throw Exception();
  }
}

abstract class LocalStorageInterface {
  dynamic getItem(String key);
  Future<void> clear();
  Future<void> flush();
  Future<void> setItem(String key, dynamic value);
  Future<void> removeItem(String key);
}