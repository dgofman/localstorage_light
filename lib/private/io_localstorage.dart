import 'dart:io';
import 'dart:convert';
import 'dart:developer';

import './localstorage.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage implements LocalStorageInterface {
  final Map<String, dynamic> _data = {};
  final File _file;

  LocalStorage._(this._file);

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
    if (_file.existsSync()) {
      _file.deleteSync();
    }
  }

  @override
  Future<void> flush() async {
    try {
      final buffer = json.encode(_data);
      await _file.writeAsString(buffer, mode: FileMode.writeOnly, flush: true);
    } catch (e) {
      log('IOLocalStorage::Error: $e');
    }
  }

  static Future<LocalStorage> init(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    final localStorage = LocalStorage._(file);
    if (file.existsSync()) {
      final contents = await file.readAsString();
      final store = json.decode(contents);
      localStorage._data.addAll(store);
    }
    return localStorage;
  }
}