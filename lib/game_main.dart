import 'dart:ui';

import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:punk_game/tap_component.dart';

import 'level.dart';

class GameMain extends FlameGame with HasCollisionDetection, HasTappableComponents, HasTappablesBridge {
  Level? _currentLevel;
  late Image spriteSheet;
  late Image background;
  late TapComponent tapComponent;
  late double screenX;
  late double screenY;

  @override
  Future<void>? onLoad() async {
    screenX = size.x;
    screenY = size.y;
    spriteSheet = await images.load('spritesheet.png');
    background = await images.load('background_gradient.png');

    camera.viewport = FixedResolutionViewport(Vector2(900, 450));
    loadLevel('level1.tmx');


    return super.onLoad();
  }
  
  @override
  void onMount() {
    tapComponent = TapComponent(size.x, size.y, screenX, screenY);
    add(tapComponent);
    super.onMount();
  }


  void loadLevel(String levelName) {
    _currentLevel?.removeFromParent();
    _currentLevel = Level(levelName);
    add(_currentLevel!);
  }
}