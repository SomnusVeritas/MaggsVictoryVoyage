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
