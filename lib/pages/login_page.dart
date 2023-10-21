import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../services/db_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _height = 0;
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    width = width < 400 ? 400 : width;
    TextEditingController username = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: _height > 0 ? 0 : 300),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: _height,
                width: 250,
                child: Image.asset('assets/images/maxio.png', height: _height),
              ),
            ),
            Card(
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
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15)),
                      TextField(
                        onTap: () => _onTap(),
                        controller: username,
                        onSubmitted: (value) => DbHelper.login(username.text),
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          label: Text('Your first name'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15)),
                      FloatingActionButton.extended(
                        onPressed: () => DbHelper.login(username.text),
                        label: const Text('READY'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 300)),
          ],
        ),
      ),
    );
  }

  Future _onTap() async {
    setState(() {
      _height = 300;
    });
    await player.play(UrlSource(
        'https://vhmrtvhcmvylhrhblyjb.supabase.co/storage/v1/object/public/audio/itsMeMax.mp3'));
  }
}
