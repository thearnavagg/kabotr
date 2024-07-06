import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static late SharedPreferences _prefs;
  static bool _initialized = false;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  static SharedPreferences get instance {
    if (!_initialized) {
      throw Exception("SharedPreferencesManager has not been initialized");
    }
    return _prefs;
  }

  static Future<void> saveUid(String uid) async {
    if (!_initialized) {
      throw Exception("SharedPreferencesManager has not been initialized");
    }
    await _prefs.setString('uid', uid);
  }

  static Future<String?> getUid() async {
    if (!_initialized) {
      throw Exception("SharedPreferencesManager has not been initialized");
    }
    return _prefs.getString('uid');
  }
}
