import 'package:flutter/material.dart';
import 'package:maggs_victory_voyage/pages/feed_page.dart';
import 'package:maggs_victory_voyage/pages/games_page.dart';
import 'package:maggs_victory_voyage/services/db_helper.dart';
import 'package:provider/provider.dart';

import '../services/feed_provider.dart';
import 'leaderboard_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final Future<bool> loginFuture;
  int currentPageIndex = 0;
  final List<Widget> tabs = [
    const GamesPage(),
    const LeaderboardPage(),
    const FeedPage(),
  ];

  @override
  void initState() {
    super.initState();
    loginFuture = DbHelper.autoLogin();
    DbHelper.authEventStream.listen((event) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loginFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _getContent();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _getContent() {
    if (DbHelper.currentUser == null) {
      return const LoginPage();
    }

    Provider.of<Feed>(context, listen: false).feed;
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () => DbHelper.logout(),
          icon: const Icon(Icons.logout),
        )
      ]),
      body: tabs.elementAt(currentPageIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.videogame_asset,
              color: Colors.white,
            ),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.emoji_events,
              color: Colors.white,
            ),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
            ),
            label: 'Events',
          ),
        ],
        currentIndex: currentPageIndex,
        onTap: (index) => setState(() => currentPageIndex = index),
      ),
    );
  }
}
