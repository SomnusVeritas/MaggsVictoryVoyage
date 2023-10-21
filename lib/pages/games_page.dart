import 'package:flutter/material.dart';
import 'package:maggs_victory_voyage/services/db_helper.dart';
import 'package:maggs_victory_voyage/widgets/games_popup.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';
import '../models/profile.dart';
import '../services/games_provider.dart';
import '../services/profiles_provider.dart';
import '../widgets/games_button.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  Profile? userProfile;
  List<Game> games = [];

  @override
  Widget build(BuildContext context) {
    userProfile = Provider.of<Profiles>(context, listen: true).own;
    games = Provider.of<Games>(context, listen: true).games;

    return Center(
      child: Column(
        children: _getGames(),
        // _getWidgets(games, context),
      ),
    );
  }

  List<Widget> _getGames() {
    if (games.isEmpty) {
      return [const CircularProgressIndicator()];
    } else {
      final List<Widget> list = [];
      for (final game in games) {
        list.add(
          GamesButton(
            title: game.name,
            buttonPressed: () {
              showDialog(
                context: context,
                builder: (context) => GamesPopup(
                  withPlacements: game.rewards.length > 1,
                  game: game,
                  onSubmitted: (placement) => _winConfirmed(placement, game),
                ),
              );
            },
          ),
        );
      }
      return list;
    }
  }

  _winConfirmed(int placement, Game game) {
    DbHelper.pushGameWin(
        userProfile!.points,
        game.rewards
            .singleWhere((element) => element.placement == placement)
            .reward);

    String feedText = '';
    if (placement == 1) {
      feedText = '${userProfile!.username} just won at ${game.name}';
    } else if (placement == 2) {
      feedText = '${userProfile!.username} just got 2nd place in ${game.name}';
    } else if (placement == 3) {
      feedText = '${userProfile!.username} just got 3rd place in ${game.name}';
    } else {
      feedText =
          '${userProfile!.username} just got ${placement}th place in ${game.name}';
    }

    DbHelper.pushFeedEntry(feedText);
  }
}
