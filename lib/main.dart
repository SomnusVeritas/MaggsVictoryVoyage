import 'package:flutter/material.dart';
import 'package:maggs_victory_voyage/services/db_helper.dart';
import 'pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(background: Colors.pink[50]),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
