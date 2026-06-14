import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _accessToken = "access_token";
  static const String _refreshToken = "refresh_token";

  static Future<void> setToken(String accessToken, String refreshToken) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_accessToken, accessToken);
    await preferences.setString(_refreshToken, refreshToken);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_accessToken);
  }

  static Future<String?> getRefreshToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_refreshToken);
  }

  static Future<void> clearToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(_accessToken);
    await preferences.remove(_refreshToken);
  }
}
