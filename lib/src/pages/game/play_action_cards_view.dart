import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/game_state.dart';

import 'action_card_view.dart';

// bottom bar
class PlayActionCardsView extends StatelessWidget {
  const PlayActionCardsView({
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
        left: 0,
        bottom: 0,
        child: SizedBox(
          width: gridWidth * 5 + space.dx * 5,
          height: gridHeight * 0.782,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              gameState.actionCards.length,
              (i) {
                final actionCard = gameState.actionCards[i];

                return ActionCardView(
                  actionCard: actionCard,
                  actionCardUse: ActionCardUse.info,
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
