import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:punk_game/game_main.dart';



class BackgroundComponent extends Component with HasGameRef<GameMain> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final parallax = ParallaxComponent(
      scale: Vector2(3,3),
      parallax: Parallax(
        await Future.wait([
          gameRef.loadParallaxLayer(
            ParallaxImageData('background_gradient.png'),
            velocityMultiplier: Vector2(0.0, 1.0),
            alignment: Alignment.bottomCenter,


          ),
          /*       loadParallaxLayer(
            ParallaxImageData('backgrounds/Waves.png'),
            velocityMultiplier: Vector2(0.0, 1.0),
            alignment: Alignment.bottomLeft,
            fill: LayerFill.width,
          ),*/
        ]),
        baseVelocity: Vector2(20, 0),
      ),
    );
    add(parallax);
  }
}