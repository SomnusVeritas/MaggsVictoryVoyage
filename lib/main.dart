import 'package:flutter/material.dart';
import 'package:maggs_victory_voyage/services/db_helper.dart';

import 'pages/login_page.dart';
import 'pages/splash_page.dart';

void main() async {
  await DbHelper.init();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maggs\' Victory Voyage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
