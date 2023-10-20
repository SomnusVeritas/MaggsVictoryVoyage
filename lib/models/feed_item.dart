class FeedItem {
  final String text;
  final DateTime timestamp;

  FeedItem.fromMap(Map<String, dynamic> map)
      : text = map['text'],
        timestamp = DateTime.parse(map['timestamp']);

  @override
  bool operator ==(Object other) {
    if (other is FeedItem) {
      return other.timestamp == timestamp;
    }
    return false;
  }
}
