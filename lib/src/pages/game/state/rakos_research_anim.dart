import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/game_state.dart';
import '../dialog/open_sea_card_dlg.dart';

// らっこリサーチで選んだカードを開示する
class RakosResearchAnim extends StatelessWidget {
  const RakosResearchAnim({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      final gameState = Provider.of<GameState>(context, listen: false);
      final seaCard = gameState.getSeaCardId(gameState.researchedSeaCardId);

      return OpenSeaCardDlg(
          seaCard: seaCard.clone(),
          onTap: () {
            if (gameState.actionCards.isNotEmpty) {
              // アクション カードがある場合
              gameState.triggerChoiceActionCard();
            } else {
              // アクション カードが無い場合
              gameState.triggerActioned();
            }
          });
    });
  }
}
