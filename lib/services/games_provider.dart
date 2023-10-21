import 'package:flutter/material.dart';
import 'package:maggs_victory_voyage/services/db_helper.dart';

import '../models/game.dart';

class Games extends ChangeNotifier {
  final List<Game> _games = [];

  List<Game> get games {
    if (_games.isEmpty) {
      DbHelper.fetchGames().then((value) {
        _games.clear();
        _games.addAll(value);
        notifyListeners();
      });
    }
    return _games;
  }
}
