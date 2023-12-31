import 'package:flutter/foundation.dart';
import 'package:maggs_victory_voyage/models/game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/feed_item.dart';
import '../models/profile.dart';

class DbHelper {
  static Future<SharedPreferences> get _prefs async =>
      SharedPreferences.getInstance();

  static final _supabase = Supabase.instance.client;

  static User? get currentUser => _supabase.auth.currentUser;

  static Stream<AuthState> get authEventStream =>
      _supabase.auth.onAuthStateChange;

  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://vhmrtvhcmvylhrhblyjb.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZobXJ0dmhjbXZ5bGhyaGJseWpiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc4MTU3MTksImV4cCI6MjAxMzM5MTcxOX0.Djltae5oIvANqHdY1cNqA1ja5aAEivr-a_XDYkSd924',
    );
  }

  static void login(String username) async {
    if (username.length < 2) return;
    final prefs = await _prefs;

    try {
      await _supabase.auth.signInWithPassword(
        email: '$username@skup.in',
        password: 'password',
      );
      await prefs.setString('username', username);
    } on AuthException catch (_) {
      await _supabase.auth.signUp(
          email: '$username@skup.in',
          password: 'password',
          data: {'username': username}).whenComplete(
        () => _supabase.from('profiles').update({'username': username}).eq(
          'id',
          currentUser!.id,
        ),
      );
      await prefs.setString('username', username);
    }
  }

  static Future<bool> autoLogin() async {
    final prefs = await _prefs;
    final String? username = prefs.getString('username');
    if (username == null) return false;
    try {
      await _supabase.auth.signInWithPassword(
        email: '$username@skup.in',
        password: 'password',
      );
      return true;
    } on AuthException catch (e) {
      if (kDebugMode) {
        print('Could\'t automaticall log in.\n${e.message}');
      }
    }
    return false;
  }

  static void logout() async {
    final prefs = await _prefs;
    await prefs.remove('username');
    _supabase.auth.signOut();
  }

  static Future<List<FeedItem>> fetchFeed() async {
    List<FeedItem> items = [];
    final res = await _supabase.from('feed').select();
    for (final map in res) {
      items.add(FeedItem.fromMap(map));
    }
    return items;
  }

  static Future<List<Profile>> fetchProfiles() async {
    List<Profile> items = [];
    final res = await _supabase.from('profiles').select().order(
          'points',
          ascending: false,
        );
    for (final map in res) {
      items.add(Profile.fromMap(map));
    }
    return items;
  }

  static Future<List<Game>> fetchGames() async {
    List<Game> games = [];
    final res = await _supabase.from('games').select().eq('active', true);
    final rewardsRes =
        await _supabase.from('rewards').select<List<Map<String, dynamic>>>();

    for (final map in res) {
      final rewards =
          rewardsRes.where((element) => element['game_id'] == map['id']);
      final game = Game.fromMap(map, rewards);
      games.add(game);
    }

    return games;
  }

  static Future<void> pushFeedEntry(String text) async {
    await _supabase
        .from('feed')
        .insert({'text': text, 'timestamp': DateTime.now().toString()});
  }

  static Future<void> pushGameWin(int currentPoints, int pointsWon) async {
    await _supabase.from('profiles').update(
        {'points': currentPoints + pointsWon}).eq('id', currentUser!.id);
  }

  static Stream<List<Map<String, dynamic>>> get feedStream =>
      _supabase.from('feed').stream(primaryKey: ['timestamp']);

  static Stream<List<Map<String, dynamic>>> get profilesStream => _supabase
      .from('profiles')
      .stream(primaryKey: ['id']).order('points', ascending: false);
}
