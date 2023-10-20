class Profile {
  final String username;
  final int points;
  final String id;

  Profile.fromMap(Map<String, dynamic> map)
      : username = map['username'],
        points = map['points'] ?? 0,
        id = map['id'];
}
