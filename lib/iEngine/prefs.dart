/// Provides shared preferences utilities via the [Prefs] class.
// ignore: unnecessary_library_name
library prefs;

import 'package:shared_preferences/shared_preferences.dart';

/// A singleton-style utility class for accessing `SharedPreferences` in a simplified way.
///
/// Call [Prefs.instance] **once before** `runApp()` to initialize.
///
/// Example:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await Prefs.instance();
///   runApp(MyApp());
/// }
///
/// final name = Prefs.getString('username');
/// await Prefs.setBool('isLoggedIn', true);
/// ```
class Prefs {
  /// Creates a new instance of [Prefs].
  Prefs();
  static late final SharedPreferences _instance;

  // ----------------------
  // 🔵 Initialization
  // ----------------------

  /// Initializes the [SharedPreferences] instance.
  ///
  /// Must be called **once before** accessing any other methods,
  /// typically in `main()` before `runApp()`.
  static Future<void> instance() async {
    _instance = await SharedPreferences.getInstance();
  }

  // ----------------------
  // 🟢 Getters
  // ----------------------

  /// Returns a `String` value associated with the given [key],
  /// or [defaultValue] if the key is not found.
  static String getString(String key, {String defaultValue = ''}) =>
      _instance.getString(key) ?? defaultValue;

  /// Returns an `int` value associated with the given [key],
  /// or [defaultValue] if the key is not found.
  static int getInt(String key, {int defaultValue = 0}) =>
      _instance.getInt(key) ?? defaultValue;

  /// Returns a `bool` value associated with the given [key],
  /// or [defaultValue] if the key is not found.
  static bool getBool(String key, {bool defaultValue = false}) =>
      _instance.getBool(key) ?? defaultValue;

  /// Returns a `double` value associated with the given [key],
  /// or [defaultValue] if the key is not found.
  static double getDouble(String key, {double defaultValue = 0.0}) =>
      _instance.getDouble(key) ?? defaultValue;

  /// Returns a list of `String` values associated with the given [key],
  /// or [defaultValue] if the key is not found.
  static List<String> getStringList(
    String key, {
    List<String> defaultValue = const [],
  }) => _instance.getStringList(key) ?? defaultValue;

  // ----------------------
  // 🟢 Setters
  // ----------------------

  /// Sets a `String` value for the given [key].
  static Future<bool> setString(String key, String value) =>
      _instance.setString(key, value);

  /// Sets an `int` value for the given [key].
  static Future<bool> setInt(String key, int value) =>
      _instance.setInt(key, value);

  /// Sets a `bool` value for the given [key].
  ///
  /// ignore: avoid_positional_boolean_parameters
  static Future<bool> setBool(String key, bool value) =>
      _instance.setBool(key, value);

  /// Sets a `double` value for the given [key].
  static Future<bool> setDouble(String key, double value) =>
      _instance.setDouble(key, value);

  /// Sets a list of `String` values for the given [key].
  static Future<bool> setStringList(String key, List<String> value) =>
      _instance.setStringList(key, value);

  // ----------------------
  // 🔴 Utilities
  // ----------------------

  /// Returns `true` if the given [key] exists in preferences.
  static bool contains(String key) => _instance.containsKey(key);

  /// Removes the value associated with the given [key].
  static Future<bool> remove(String key) => _instance.remove(key);

  /// Clears all keys and values from preferences.
  static Future<bool> clear() => _instance.clear();
}
