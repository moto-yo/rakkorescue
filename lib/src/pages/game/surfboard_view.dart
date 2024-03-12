import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/game_state.dart';
import '../../assets/play_images.dart';

// サーファー
class SurfboardView extends StatelessWidget {
  const SurfboardView({
    super.key,
    required this.gridWidth,
    required this.gridHeight,
    required this.space,
  });

  final double gridWidth;
  final double gridHeight;
  final Offset space;

  // 開始前は 5x5 gridの左下
  // gameState.surfboardI < 0

  static const List<Offset> ds = [
    Offset(0, -1), // -1
    Offset(0, 0), // 0
    Offset(0, 1), // 1
    Offset(0, 2), // 2
    Offset(0, 3), // 3
    Offset(0, 4), // 4
    Offset(1, 4), // 5
    Offset(2, 4), // 6
    Offset(3, 4), // 7
    Offset(4, 4), // 8
    Offset(4, 3), // 9
    Offset(4, 2), // 10
    Offset(4, 1), // 11
    Offset(4, 0), // 12
    Offset(3, 0), // 13
    Offset(2, 0), // 14
    Offset(1, 0), // 15
    Offset(0, -1), // 16, goal
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      final d = ds[1 + gameState.surfboardI];

      // print("surfboardI = ${gameState.surfboardI}");

      return Positioned(
        left: d.dx * (gridWidth + space.dx),
        bottom: 6 + (1 + d.dy) * (gridHeight + space.dy),
        child: SizedBox(
          width: gridWidth * 116 / 272,
          height: gridHeight * 132 / 302,
          child: const Image(image: PlayImages.surfboard),
        ),
      );
    });
  }
}
