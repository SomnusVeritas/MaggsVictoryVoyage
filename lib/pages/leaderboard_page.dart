import 'package:flutter/material.dart';
import 'package:maggs_victory_voyage/services/db_helper.dart';
import 'package:provider/provider.dart';
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
          final isLoggedInUser =
              leaderboard.elementAt(index).id == DbHelper.currentUser!.id;
          return Card(
            color:
                isLoggedInUser ? Theme.of(context).colorScheme.secondary : null,
            child: ListTile(
              leading: Text((index + 1).toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isLoggedInUser
                            ? Theme.of(context).colorScheme.onSecondary
                            : null,
                      )),
              title: Text(
                leaderboard.elementAt(index).username,
                style: TextStyle(
                  color: isLoggedInUser
                      ? Theme.of(context).colorScheme.onSecondary
                      : null,
                ),
              ),
              trailing: Text(leaderboard.elementAt(index).points.toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isLoggedInUser
                            ? Theme.of(context).colorScheme.onSecondary
                            : null,
                      )),
            ),
          );
        });
  }
}
