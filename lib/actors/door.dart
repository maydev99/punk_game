import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:punk_game/actors/player.dart';
import 'package:punk_game/game_main.dart';


// Represents a door in the game world.
class Door extends SpriteComponent with CollisionCallbacks, HasGameRef<GameMain> {
  Function? onPlayerEnter;

  Door(
      Image image, {
        this.onPlayerEnter,
        Vector2? position,
        Vector2? size,
        Vector2? scale,
        double? angle,
        Anchor? anchor,
        int? priority,
      }) : super.fromImage(
    image,
    srcPosition: Vector2(0, 2 * 64),
    srcSize: Vector2.all(62),
    position: position,
    size: size,
    scale: scale,
    angle: angle,
    anchor: anchor,
    priority: priority,
  );

  @override
  Future<void>? onLoad() {
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      print('Door');

      //other.removeFromParent();
      onPlayerEnter?.call();




    }
    super.onCollisionStart(intersectionPoints, other);
  }
}