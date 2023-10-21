class Reward {
  final int placement;
  final int reward;

  Reward.fromMap(Map<String, dynamic> map)
      : placement = map['placement'],
        reward = map['reward'];
}
