import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String? get token => _sharedPreferences.getString('token');

  static Future<void> setToken(String token) async =>
      await _sharedPreferences.setString('token', token);

  static Future<void> deleteToken() async {
    await _sharedPreferences.remove('token');
  }
}
