import 'package:flutter/material.dart';
import 'package:maggs_victory_voyage/services/db_helper.dart';

import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final Future<bool> loginFuture;

  @override
  void initState() {
    super.initState();
    loginFuture = DbHelper.autoLogin();
    DbHelper.authEventStream.listen((event) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loginFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (DbHelper.currentUser == null) {
              return const LoginPage();
            }
            return const Column(
              children: [
                Text('Logged in!'),
                TextButton(
                  onPressed: DbHelper.logout,
                  child: Text('Log out'),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
