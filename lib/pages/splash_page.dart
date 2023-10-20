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
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    loginFuture = DbHelper.autoLogin();
    DbHelper.authEventStream.listen((event) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loginFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _getContent();
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _getContent() {
    if (DbHelper.currentUser == null) {
      return const LoginPage();
    }
    return Scaffold(
      body: const Column(
        children: [
          Text('Logged in!'),
          TextButton(
            onPressed: DbHelper.logout,
            child: Text('Log out'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
            ),
            label: 'Events',
          ),
        ],
        currentIndex: currentPageIndex,
        onTap: (index) => setState(() => currentPageIndex = index),
      ),
    );
  }
}
