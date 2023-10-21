class Game {
  final int id;
  final String name;
  final List<Map<String, dynamic>> rewards;

  Game.fromMap(Map<String, dynamic> map, Iterable<Map<String, dynamic>> rewards)
      : id = map['id'],
        name = map['name'],
        rewards = rewards.toList();
}
