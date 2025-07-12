import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late final SharedPreferences _instance;

  /// Call once in main before runApp
  static Future<void> instance() async {
    _instance = await SharedPreferences.getInstance();
  }

  /// 🟢 Getters
  static String getString(String key, {String defaultValue = ''}) =>
      _instance.getString(key) ?? defaultValue;

  static int getInt(String key, {int defaultValue = 0}) =>
      _instance.getInt(key) ?? defaultValue;

  static bool getBool(String key, {bool defaultValue = false}) =>
      _instance.getBool(key) ?? defaultValue;

  static double getDouble(String key, {double defaultValue = 0.0}) =>
      _instance.getDouble(key) ?? defaultValue;

  static List<String> getStringList(
    String key, {
    List<String> defaultValue = const [],
  }) => _instance.getStringList(key) ?? defaultValue;

  /// 🟢 Setters
  static Future<bool> setString(String key, String value) =>
      _instance.setString(key, value);
  static Future<bool> setInt(String key, int value) =>
      _instance.setInt(key, value);
  // ignore: avoid_positional_boolean_parameters
  static Future<bool> setBool(String key, bool value) =>
      _instance.setBool(key, value);
  static Future<bool> setDouble(String key, double value) =>
      _instance.setDouble(key, value);
  static Future<bool> setStringList(String key, List<String> value) =>
      _instance.setStringList(key, value);

  /// 🔴 Utility
  static bool contains(String key) => _instance.containsKey(key);
  static Future<bool> remove(String key) => _instance.remove(key);
  static Future<bool> clear() => _instance.clear();
}
