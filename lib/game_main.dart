import 'dart:ui';

import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:punk_game/actors/player.dart';
import 'package:punk_game/tap_component.dart';

import 'level.dart';

class GameMain extends FlameGame with HasCollisionDetection, HasTappableComponents, HasTappablesBridge {
  Level? _currentLevel;
  late Image spriteSheet;
  late Image background;
  late Image background2;
  late Image punky;
  late TapComponent tapComponent;
  late double screenX;
  late double screenY;
  late final Player player;

  @override
  Future<void>? onLoad() async {

    screenX = size.x;
    screenY = size.y;
    spriteSheet = await images.load('spritesheet.png');
    background = await images.load('background_gradient.png');
    background2 = await images.load('sky2.png');
    punky = await images.load('punky_64.png');


    camera.viewport = FixedResolutionViewport(Vector2(900, 450));
    loadLevel('level1.tmx');


    return super.onLoad();
  }
  
  @override
  void onMount() {

    super.onMount();
  }


  void loadLevel(String levelName) {
    _currentLevel?.removeFromParent();
    _currentLevel = Level(levelName);
    add(_currentLevel!);
    tapComponent = TapComponent(size.x, size.y, screenX, screenY);
    add(tapComponent);

  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        resumeEngine();
        /*if (!(overlays.isActive(PauseOverlay.id)) &&
            !(overlays.isActive(PauseOverlay.id))) {

        }*/

        break;
      case AppLifecycleState.paused:


        break;
      case AppLifecycleState.detached:
        //overlays.add(PauseOverlay.id);
        //saveHighScore();
        pauseEngine();
        break;
      case AppLifecycleState.inactive:
        /*if (overlays.isActive(HudOverlay.id)) {
          overlays.remove(HudOverlay.id);
          overlays.add(PauseOverlay.id);
        }*/

        pauseEngine();
        //saveHighScore();

        break;
    }
    super.lifecycleStateChange(state);
  }
}