import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Create a FlutterSecureStorage instance
  static const _storage = FlutterSecureStorage();

  // Save data
  static Future<void> saveData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Retrieve data
  static Future<String?> getData(String key) async {
    return await _storage.read(key: key);
  }

  // Remove data
  static Future<void> removeData(String key) async {
    await _storage.delete(key: key);
  }

  // Clear all data
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  static Future<void> saveStringList(String key, List<String> value) async {
    final jsonString = jsonEncode(value);
    await _storage.write(key: key, value: jsonString);
  }

  // Retrieve a list of strings
  static Future<List<String>?> getStringList(String key) async {
    final jsonString = await _storage.read(key: key);
    if (jsonString != null) {
      return List<String>.from(jsonDecode(jsonString));
    }
    return null;
  }

}
