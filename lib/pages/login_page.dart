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
              const Text('Welcome!',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              TextField(
                controller: username,
                decoration: const InputDecoration(
                  label: Text('Username'),
                  border: OutlineInputBorder(),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              ElevatedButton(
                onPressed: () => DbHelper.login(username.text),
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
