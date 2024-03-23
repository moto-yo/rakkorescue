import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

// らっこの岩場🪨
class RockyBeachView extends StatelessWidget {
  const RockyBeachView({
    super.key,
    required this.gridWidth,
    required this.gridHeight,
    required this.space,
  });

  final double gridWidth;
  final double gridHeight;
  final Offset space;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return Positioned(
        top: gridHeight * 3 + space.dy * 2,
        left: gridWidth + space.dx,
        child: SizedBox(
          width: gridWidth * 4 + space.dx * 4,
          height: gridHeight + space.dy,
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.topRight,
            child: Row(
              children: [
                Column(children: [
                  Visibility(
                    visible: 1 < gameState.repairedBoatN + gameState.brokenBoatN,
                    child: BoardView(isBroken: gameState.repairedBoatN <= 1, n: math.min(gameState.helpedRakkoN - 5 - 4, 4)),
                  ),
                  Visibility(
                    visible: 2 < gameState.repairedBoatN + gameState.brokenBoatN,
                    child: BoardView(isBroken: gameState.repairedBoatN <= 2, n: gameState.helpedRakkoN - 5 - 4 * 2),
                  ),
                ]),
                Column(children: [
                  BoardView(isBroken: false, n: math.min(gameState.helpedRakkoN, 5)),
                  Visibility(
                    visible: 0 < gameState.repairedBoatN + gameState.brokenBoatN,
                    child: BoardView(isBroken: gameState.repairedBoatN <= 0, n: math.min(gameState.helpedRakkoN - 5, 4)),
                  ),
                ]),
                Container(
                  width: 462,
                  height: 334,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: PlayImages.rockyBeach,
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              ((6 <= gameState.waitingRakkoN)
                                  ? (const Visibility(
                                      visible: false,
                                      child: Image(image: PlayImages.rakkoFace),
                                    ))
                                  : const SizedBox(width: 109, height: 102)),
                              ((7 <= gameState.waitingRakkoN)
                                  ? (const Visibility(
                                      visible: false,
                                      child: Image(image: PlayImages.rakkoFace),
                                    ))
                                  : const SizedBox(width: 109, height: 102)),
                            ],
                          ),
                          Row(
                            children: [
                              ((4 <= gameState.waitingRakkoN)
                                  ? (const Visibility(
                                      visible: false,
                                      child: Image(image: PlayImages.rakkoFace),
                                    ))
                                  : const SizedBox(width: 109, height: 102)),
                              ((5 <= gameState.waitingRakkoN)
                                  ? (const Visibility(
                                      visible: false,
                                      child: Image(image: PlayImages.rakkoFace),
                                    ))
                                  : const SizedBox(width: 109, height: 102)),
                            ],
                          ),
                          Row(
                            children: [
                              ((2 <= gameState.waitingRakkoN)
                                  ? (const Visibility(
                                      visible: false,
                                      child: Image(image: PlayImages.rakkoFace),
                                    ))
                                  : const SizedBox(width: 109, height: 102)),
                              ((3 <= gameState.waitingRakkoN)
                                  ? (const Visibility(
                                      visible: false,
                                      child: Image(image: PlayImages.rakkoFace),
                                    ))
                                  : const SizedBox(width: 109, height: 102)),
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 130),
                            child: Text(
                              '${gameState.waitingRakkoN}',
                              style: const TextStyle(
                                fontSize: 96,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          (1 <= gameState.waitingRakkoN)
                              ? Container(
                                  alignment: Alignment.bottomCenter,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: const Image(image: PlayImages.rakkoHelp),
                                )
                              : const SizedBox(width: 230, height: 206),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class BoardView extends StatelessWidget {
  const BoardView({
    super.key,
    required this.isBroken,
    required this.n,
  });

  final bool isBroken;
  final int n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353,
      height: 165,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isBroken ? PlayImages.brokenBoard : PlayImages.board,
          fit: BoxFit.contain,
        ),
      ),
      child: Visibility(
        visible: 0 < n,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 21, right: 16),
              child: const Image(image: PlayImages.rakkoFace),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 41),
              child: Text(
                '$n',
                style: const TextStyle(
                  fontSize: 82,
                  color: Color(0xff8e6d46),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
