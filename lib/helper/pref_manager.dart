import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
//-----------------------------------

  static void clear() async {
    final p = await prefs;
    p.clear();
  }

  static Future<bool> getBool(String key) async {
    final p = await prefs;
    return p.getBool(key) ?? true;
  }

  static Future setBool(String key, bool value) async {
    final p = await prefs;
    return p.setBool(key, value);
  }

  static Future<int> getInt(String key) async {
    final p = await prefs;
    return p.getInt(key) ?? 0;
  }

  static Future setInt(String key, int value) async {
    final p = await prefs;
    return p.setInt(key, value);
  }

  static Future<String> getString(String key) async {
    final p = await prefs;
    return p.getString(key) ?? '';
  }

  static Future setString(String key, String value) async {
    final p = await prefs;
    return p.setString(key, value);
  }

  static Future<double> getDouble(String key) async {
    final p = await prefs;
    return p.getDouble(key) ?? 0.0;
  }

  static Future setDouble(String key, double value) async {
    final p = await prefs;
    return p.setDouble(key, value);
  }

  static dynamic getFromJson(String key) async {
    String json = await getString(key);
    return jsonDecode(json);
  }

  static Future setToJson(String key, Object object) {
    String json = jsonEncode(object);
    return SharedPrefsManager.setString(key, json);
  }
  // helper

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
