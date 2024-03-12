import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/game_state.dart';

import '../open_sea_card_widget.dart';

class OpenSeaCard extends StatelessWidget {
  const OpenSeaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      final gameState = Provider.of<GameState>(context, listen: false);
      final seaCard = gameState.getSeaCardId(gameState.openSeaCardId);

      return OpenSeaCardWidget(
          seaCard: seaCard,
          onTap: () {
            // 遷移する
            gameState.triggerOpenedSeaCard();
          });
    });
  }
}
