import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:punk_game/actors/background.dart';
import 'package:punk_game/actors/enemy.dart';
import 'package:punk_game/actors/player.dart';


import 'package:tiled/tiled.dart';

import 'actors/background2.dart';
import 'actors/door.dart';
import 'actors/key.dart';
import 'actors/platform.dart';

import 'game_main.dart';


class Level extends Component with HasGameRef<GameMain> {
  final String levelName;
  late Player player;
  late Rect levelBounds;

  late Background background;
  //late BackgroundComponent backgroundComponent;

  Level(this.levelName) : super();

  @override
  Future<void>? onLoad() async {
    final level = await TiledComponent.load(levelName, Vector2.all(64));
    //backgroundComponent = BackgroundComponent();


    levelBounds = Rect.fromLTWH(
        0,
        0,
        (level.tileMap.map.width * level.tileMap.map.tileWidth).toDouble(),
        (level.tileMap.map.height * level.tileMap.map.tileHeight).toDouble());


    await spawnActors(level.tileMap);
    await add(level);
    await setupCamera();
    return super.onLoad();
  }

  spawnActors(RenderableTiledMap tileMap) async {


    final bkg = Background(gameRef.background,
        position: Vector2(0,0),
        size: Vector2(1920, 1280));
    bkg.changePriorityWithoutResorting(0);
    await add(bkg);
    //final bkg = BackgroundComponent();
    //await add(bkg);
    //backgroundComponent.changePriorityWithoutResorting(0);


    final platformsLayer = tileMap.getLayer<ObjectGroup>('PlatformsLayer');

    for (final platformObject in platformsLayer!.objects) {
      final platform = Platform(
        position: Vector2(platformObject.x, platformObject.y),
        size: Vector2(platformObject.width, platformObject.height),
      );
      add(platform);
    }


    final spawnPointsLayer = tileMap.getLayer<ObjectGroup>('SpawnLayer');
    for (final spawnPoint in spawnPointsLayer!.objects) {
      final position = Vector2(spawnPoint.x, spawnPoint.y - spawnPoint.height);
      final size = Vector2(spawnPoint.width, spawnPoint.height);
      switch (spawnPoint.name) {
        case 'Player':
          player = Player(gameRef.spriteSheet,
              anchor: Anchor.center,
              levelBounds: levelBounds,
            position: Vector2(spawnPoint.x, spawnPoint.y),
            size: size
          );
          add(player);
          break;
   /* case 'Star':
          final star =
          Star(gameRef.spriteSheet, position: position, size: size);
          add(star);
          break;*/

        case 'Door':
          final door = Door(gameRef.spriteSheet, position: position, size: size,
              onPlayerEnter: () {
                gameRef.loadLevel(spawnPoint.properties.first.value);
              });

          add(door);
          break;

       /* case 'Teleporter':
          final targetObjectId = int.parse(spawnPoint.properties.first.value);
          final teleporter = Teleporter(gameRef.teleporterImage,
              position: position, size: size, onPlayerEnter: () {
                final target = spawnPointsLayer.objects
                    .firstWhere((object) => object.id == targetObjectId);
                player.teleportToPosition(Vector2(target.x, target.y));
              });
          add(teleporter);
          break;*/

        case 'Key':
          final key = Key(
            gameRef.spriteSheet,
            position: position,
            size: size,
          );
          add(key);
          break;

        case 'Enemy':
          final targetObjectId = int.parse(spawnPoint.properties.first.value);
          final target = spawnPointsLayer.objects
              .firstWhere((object) => object.id == targetObjectId);
          final enemy = Enemy(gameRef.spriteSheet,
              position: position,
              targetPosition: Vector2(target.x, target.y),
              size: size);
          add(enemy);
          break;

       /* case 'MovingPlatform':
          final targetObjectId = int.parse(spawnPoint.properties.first.value);
          final target = spawnPointsLayer.objects
              .firstWhere((object) => object.id == targetObjectId);
          final movingPlatform = MovingPlatform(gameRef.spriteSheet,
              position: position,
              targetPosition: Vector2(target.x, target.y),
              size: size);
          add(movingPlatform);
          break;*/
  }
}}

setupCamera() {
  gameRef.camera.followComponent(player);
  gameRef.camera.worldBounds = levelBounds;
}}