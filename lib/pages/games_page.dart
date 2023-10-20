import 'package:flutter/material.dart';
import 'package:maggs_victory_voyage/services/db_helper.dart';
import 'package:provider/provider.dart';

import '../models/profile.dart';
import '../services/profiles_provider.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  Profile? userProfile;
  final List<Map<String, dynamic>> games = [
    {
      'name': 'Mario Kart',
      'points': 4,
    },
    {
      'name': 'Mario Party',
      'points': 6,
    },
    {
      'name': 'Exploding Kittens',
      'points': 2,
    },
    {
      'name': 'Twister',
      'points': 2,
    }
  ];
  @override
  Widget build(BuildContext context) {
    userProfile = Provider.of<Profiles>(context, listen: true).own;

    return Center(
      child: Column(
        children: _getWidgets(games, context),
      ),
    );
  }

  List<Widget> _getWidgets(
      List<Map<String, dynamic>> games, BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;
    List<Widget> widgets = [];
    for (final game in games) {
      widgets.add(
        Expanded(
          child: SizedBox(
            width: width,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _getGamesButton(context, game)),
          ),
        ),
      );
    }
    return widgets;
  }

  Text _getText(String text, BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  ElevatedButton _getGamesButton(
      BuildContext context, Map<String, dynamic> game) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shape: const BeveledRectangleBorder()),
      onPressed: () => _onPressed(game),
      child: _getText(game['name'], context),
    );
  }

  void _onPressed(Map<String, dynamic> game) {
    DbHelper.pushGameWin(userProfile!.points, game['points']);
    DbHelper.pushFeedEntry(
        '${userProfile!.username} just won at ${game['name']}');
  }
}
