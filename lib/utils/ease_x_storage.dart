import 'package:shared_preferences/shared_preferences.dart';

/// 📦 Simplified key-value storage using SharedPreferences.
/// Usage: 
/// - `EaseXStorage.setString('token', 'abc123')`
/// - `final token = EaseXStorage.getString('token')`
class EaseXStorage {
  static SharedPreferences? _prefs;

  /// Initialize SharedPreferences (call this once before use).
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// 🗝️ Save a String value.
  static Future<bool> setString(String key, String value) async {
    assert(_prefs != null, 'Call EaseXStorage.init() first!');
    return await _prefs!.setString(key, value);
  }

  /// 📖 Get a String value (returns `null` if key doesn't exist).
  static String? getString(String key) {
    assert(_prefs != null, 'Call EaseXStorage.init() first!');
    return _prefs!.getString(key);
  }

  /// ✅ Save a bool value.
  static Future<bool> setBool(String key, bool value) async {
    assert(_prefs != null, 'Call EaseXStorage.init() first!');
    return await _prefs!.setBool(key, value);
  }

  /// 🔍 Get a bool value (defaults to `false` if key doesn't exist).
  static bool getBool(String key, {bool defaultValue = false}) {
    assert(_prefs != null, 'Call EaseXStorage.init() first!');
    return _prefs!.getBool(key) ?? defaultValue;
  }

  /// 🗑️ Delete a key.
  static Future<bool> remove(String key) async {
    assert(_prefs != null, 'Call EaseXStorage.init() first!');
    return await _prefs!.remove(key);
  }

  /// 🧹 Clear all stored data.
  static Future<bool> clear() async {
    assert(_prefs != null, 'Call EaseXStorage.init() first!');
    return await _prefs!.clear();
  }
}