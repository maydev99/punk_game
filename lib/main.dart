
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:punk_game/game_main.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  final _game = GameMain();
  await GetStorage.init();
  runApp(GameWidget(game: _game));
}



/*
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var gameMain = _game;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jungle Adventure',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
          body:  gameMain),
    );

  }
}*/
