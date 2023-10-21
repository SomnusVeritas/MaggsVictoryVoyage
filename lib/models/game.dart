import 'reward.dart';

class Game {
  final int id;
  final String name;
  final List<Reward> rewards;

  Game.fromMap(Map<String, dynamic> map, Iterable<Map<String, dynamic>> rewards)
      : id = map['id'],
        name = map['name'],
        rewards = rewards.map((e) => Reward.fromMap(e)).toList();
}
