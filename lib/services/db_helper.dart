import 'package:shared_preferences/shared_preferences.dart';

class DbHelper {
  static Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  static void login(String username) async {
    final prefs = await _prefs;
    final String? savedUsername = prefs.getString('username');

    if (savedUsername == null) {
      await prefs.setString('username', username);
      // TODO create new account
    } else if (savedUsername == username) {
      // TODO log into database
    } else {
      // TODO wrong username
    }
  }

  static void logout() async {
    final prefs = await _prefs;
    bool success = await prefs.remove('username');

    //TODO log out on database
  }
}
