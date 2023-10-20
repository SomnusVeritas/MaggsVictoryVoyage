import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/profile.dart';
import '../services/profiles_provider.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final leaderboard = Provider.of<Profiles>(context).profiles;
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: leaderboard.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text((index + 1).toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            title: Text(leaderboard.first.username),
            trailing: Text(leaderboard.first.points.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
          );
        });
  }
}
