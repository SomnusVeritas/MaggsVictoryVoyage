import 'package:flutter/material.dart';
import 'package:maggs_victory_voyage/services/db_helper.dart';

import '../models/feed_item.dart';

class Feed extends ChangeNotifier {
  final List<FeedItem> _feed = [];
  Stream? feedStream;

  List<FeedItem> get feed {
    if (feedStream == null) {
      DbHelper.fetchFeed().then((value) {
        _feed.clear();
        _feed.addAll(value);
      });
      feedStream = DbHelper.feedStream;
      feedStream!.listen(
        (event) => _updateFeed(event),
      );
    }
    return _feed;
  }

  void _updateFeed(List<Map<String, dynamic>> data) {
    final List<FeedItem> newFeed =
        data.map((e) => FeedItem.fromMap(e)).toList();

    final newItems =
        newFeed.where((element) => !_feed.contains(element)).toList();

    if (newItems.isNotEmpty) {
      _feed.addAll(newItems);
      notifyListeners();
    }
  }
}
