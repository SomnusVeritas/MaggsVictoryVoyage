import 'package:flutter/material.dart';
import 'package:maggs_victory_voyage/services/feed_provider.dart';
import 'package:provider/provider.dart';
import 'package:maggs_victory_voyage/services/db_helper.dart';
import 'pages/splash_page.dart';
import 'services/profiles_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Feed(),
        ),
        ChangeNotifierProvider(
          create: (_) => Profiles(),
        )
      ],
      child: const Application(),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maggs\' Victory Voyage',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 233, 206, 252)),
          // .copyWith(background: const Color.fromARGB(255, 74, 186, 145)),
          useMaterial3: true,
          fontFamily: 'Ubuntu'),
      home: const SplashPage(),
    );
  }
}
