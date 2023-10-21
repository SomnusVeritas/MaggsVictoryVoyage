import 'package:flutter/material.dart';

class GamesButton extends StatelessWidget {
  const GamesButton(
      {super.key, required this.title, required this.buttonPressed});
  final String title;
  final VoidCallback buttonPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              FloatingActionButton.extended(
                onPressed: buttonPressed,
                label: const Text('I won'),
                icon: const Icon(Icons.celebration),
              )
            ],
          ),
        ),
      ),
    );
  }
}
