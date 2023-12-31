import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/feed_provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    final feed = Provider.of<Feed>(context, listen: true).feed.reversed;
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: feed.length,
      itemBuilder: (context, index) {
        final feedItem = feed.elementAt(index);
        return Card(
          child: ListTile(
            title: Text(feedItem.text),
            subtitle: Text(getTimeString(feedItem.timestamp)),
            trailing: Text(
              '${feedItem.timestamp.hour}:${feedItem.timestamp.minute}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
            ),
          ),
        );
      },
    );
  }
}

String getTimeString(DateTime time) {
  DateTime now = DateTime.now();
  final duration = Duration(
    hours: now.hour - time.hour,
    days: now.day - time.day,
    minutes: now.minute - time.minute,
  );
  if (duration.inDays == 1) {
    return 'Yesterday';
  } else if (duration.inDays > 1) {
    return '${duration.inDays} days ago';
  } else if (duration.inHours > 0) {
    String text = duration.inHours == 1 ? 'hour' : 'hours';
    return '${duration.inHours} $text ago';
  } else if (duration.inMinutes > 0) {
    String text = duration.inMinutes == 1 ? 'minute' : 'minutes';
    return '${duration.inMinutes} $text ago';
  } else {
    return 'just seconds ago';
  }
}
