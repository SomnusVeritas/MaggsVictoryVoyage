import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final games = [
      'Mario Kart',
      'Mario Party',
      'Exploding Kittens',
      'Twister',
    ];
    return Center(
      child: Column(
        children: _getWidgets(games, context),
      ),
    );
  }

  List<Widget> _getWidgets(List<String> list, BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;
    List<Widget> widgets = [];
    for (final game in list) {
      widgets.add(
        Expanded(
          child: SizedBox(
            width: width,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _getGamesButton(() {}, game, context)),
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
      void Function()? onPressed, String title, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shape: const BeveledRectangleBorder()),
      onPressed: onPressed,
      child: _getText(title, context),
    );
  }
}
