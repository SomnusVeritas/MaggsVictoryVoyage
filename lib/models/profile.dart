class Profile {
  final String username;
  final int points;

  Profile.fromMap(Map<String, dynamic> map)
      : username = map['username'],
        points = map['points'] ?? 0;

  Profile(this.username, this.points);
}
