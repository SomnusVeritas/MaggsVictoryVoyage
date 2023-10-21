import 'package:flutter/material.dart';

import '../models/game.dart';

typedef IntCallback = Function(int);

class GamesPopup extends StatelessWidget {
  const GamesPopup({
    super.key,
    this.withPlacements = false,
    required this.onSubmitted,
    required this.game,
  });
  final bool withPlacements;
  final IntCallback onSubmitted;
  final Game game;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: AlertDialog(
        title: _getTitle(withPlacements),
        content: _getContent(withPlacements),
      ),
    );
  }

  Widget _getTitle(bool withPlacements) {
    if (withPlacements) {
      return const Text('Which place did you achieve?');
    }
    return Text('Confirm you won at ${game.name}');
  }

  Widget _getContent(bool withPlacements) {
    if (withPlacements) {
      return const Text('');
    } else {
      return const Text('');
    }
  }
}
