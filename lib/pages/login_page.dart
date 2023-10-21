import 'package:flutter/material.dart';

import '../services/db_helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    width = width < 400 ? 400 : width;
    TextEditingController username = TextEditingController();
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome!',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Text('please enter your first name to get started',
                      style: Theme.of(context).textTheme.bodyLarge),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  TextField(
                    controller: username,
                    onSubmitted: (value) => DbHelper.login(username.text),
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      label: Text('Your first name'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  FloatingActionButton.extended(
                    onPressed: () => DbHelper.login(username.text),
                    label: const Text('READY'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
