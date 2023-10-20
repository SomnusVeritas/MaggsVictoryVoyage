import 'package:flutter/material.dart';

import '../services/db_helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: username,
              decoration: const InputDecoration(
                label: Text('Username'),
              ),
            ),
            TextButton(
              onPressed: () => DbHelper.login(username.text),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => DbHelper.logout(),
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
