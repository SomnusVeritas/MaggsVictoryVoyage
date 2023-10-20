import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Mario Kart'),
        Text('Exploding Kittens'),
        Text('Twister'),
        Text('Mario Party')
      ],
    );
  }
}
