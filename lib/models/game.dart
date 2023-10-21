class Game {
  final int id;
  final String name;

  Game.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'];
}
