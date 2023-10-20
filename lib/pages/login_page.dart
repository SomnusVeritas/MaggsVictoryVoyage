import 'package:flutter/material.dart';

import '../services/db_helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    TextEditingController username = TextEditingController();
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width / 2,
          child: Column(
            children: [
              const Text('Please enter your first name',
                  style: TextStyle(
                    color: Colors.pink,
                  )),
              TextField(
                controller: username,
                decoration: const InputDecoration(
                  label: Text('Username!'),
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
      ),
    );
  }
}
