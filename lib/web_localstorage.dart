// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:convert';
import 'dart:developer';

import './localstorage.dart';

class LocalStorage  implements LocalStorageInterface {
  final Map<String, dynamic> _data = {};
  final String _fileName;

  LocalStorage._(this._fileName);

  @override
  dynamic getItem(String key) {
    return _data[key];
  }

  @override
  Future<void> setItem(String key, dynamic value) async {
    _data[key] = value;
    await flush();
  }

  @override
  Future<void> removeItem(String key) async {
    _data.remove(key);
    await flush();
  }

  @override
  Future<void> clear()  async {
    _data.clear();
    window.localStorage.remove(_fileName);
  }

  @override
  Future<void> flush() async {
    try {
      final buffer = json.encode(_data);
      window.localStorage.update(_fileName,
            (val) => buffer,
        ifAbsent: () => buffer,
      );
    } catch (e) {
      log('WebLocalStorage::Error: $e');
    }
  }

  static Future<LocalStorage> init(String fileName) async {
    final localStorage = LocalStorage._(fileName);
    final contents = window.localStorage.entries.firstWhere((i) => i.key == fileName, orElse: () => const MapEntry('', '{}'));
    final store = json.decode(contents.value);
    localStorage._data.addAll(store);
    return localStorage;
  }
}