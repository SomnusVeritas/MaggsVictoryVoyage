import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbHelper {
  static Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  static final _supabase = Supabase.instance.client;

  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://vhmrtvhcmvylhrhblyjb.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZobXJ0dmhjbXZ5bGhyaGJseWpiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc4MTU3MTksImV4cCI6MjAxMzM5MTcxOX0.Djltae5oIvANqHdY1cNqA1ja5aAEivr-a_XDYkSd924',
    );
  }

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
