import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _loggedInEmailKey = 'loggedInEmail';

  // Set the logged-in email
  static Future<void> setLoggedInEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loggedInEmailKey, email);
  }

  // Get the logged-in email
  static Future<String?> getLoggedInEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_loggedInEmailKey);
  }

  // Clear the session (logout)
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInEmailKey);
  }
}