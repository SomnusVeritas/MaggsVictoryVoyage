import 'package:flutter/material.dart';

import '../models/profile.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final leaderboard = [
      Profile('Alina', 123),
    ];
    return const Placeholder();
  }
}
