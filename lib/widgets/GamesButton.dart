import 'package:flutter/material.dart';

class GamesButton extends StatelessWidget {
  const GamesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
      child: Row(children: [
        const Text('Title'),
        TextButton(
          child: const Text('I won'),
          onPressed: () {},
        )
      ]),
    ));
  }
}
