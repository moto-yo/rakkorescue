import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/game_state.dart';
import '../../interfaces/sea_card.dart';

// info
class PlayInfoView extends StatelessWidget {
  const PlayInfoView({super.key});

  static const height = 42.0;
  static const _seaSuits = [SeaSuit.heart, SeaSuit.spade, SeaSuit.diamond];
  static const _seaSuitIcons = ['♡', '♤', '♢'];

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return SizedBox(
        height: PlayInfoView.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '🦦${gameState.helpedRakkoN}/${5 + gameState.repairedBoatN * 4}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '🛶${gameState.brokenBoatN}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '⛵️${gameState.repairedBoatN}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            ..._seaSuits.map((suit) {
              return Row(
                children: [
                  Text(
                    _seaSuitIcons[suit.index],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  ...List.generate(5, (n) {
                    final count = gameState.debriCardCounts(suit, n);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$n',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '$count',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    );
                  }),
                ],
              );
            }),
            Text(
              '🌗${gameState.roundI}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      );
    });
  }
}
