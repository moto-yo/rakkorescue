import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../state/game_state.dart';

// アクション カード
enum ActionType {
  help, // らっこの手助け💪 1x3枚, 2x3枚, 3x3枚, 4x3枚
  surfing, // 波乗りアゲイン🏄‍♂️ 2枚
  research, // らっこリサーチ👀 2枚
}

class ActionCard {
  final ActionType action;
  final int n;

  const ActionCard(this.action, this.n);

  String getBody(BuildContext context) {
    String body;

    switch (action) {
      case ActionType.help:
        {
          /*
          final nums = List.generate(n, (i) {
            return '${1 + i}';
          }).join(', ');
          */

          final bodies = [
            AppLocalizations.of(context)?.trashPickup1Body ?? 'trashPickup1Body',
            AppLocalizations.of(context)?.trashPickup2Body ?? 'trashPickup2Body',
            AppLocalizations.of(context)?.trashPickup3Body ?? 'trashPickup3Body',
            AppLocalizations.of(context)?.trashPickup4Body ?? 'trashPickup4Body',
          ];

          body = bodies[n - 1]; // '$numsの数字のゴミと壊れたボードをとりのぞけるよ';

          break;
        }

      case ActionType.surfing:
        body = AppLocalizations.of(context)?.surfAgainBody ?? 'surfAgainBody'; // 'サイコロをふりなおせるよ';

        break;

      case ActionType.research:
        body = AppLocalizations.of(context)?.seaOtterSearchBody ?? 'seaOtterSearchBody'; // '波を 1つ見ることができるよ';

        break;
    }

    return body;
  }

  // このアクション カードが使える場合 true
  bool canUse(GameState gameState) {
    switch (action) {
      case ActionType.help:
        for (int i = 0; i < 16; i++) {
          final seaCard = gameState.getSeaCardIndex(i);

          if (seaCard.isOpened && (seaCard.suit.index <= 3) && (seaCard.n <= n)) {
            return true;
          }
        }

        break;

      case ActionType.surfing:
        return true;

      case ActionType.research:
        for (int i = 0; i < 16; i++) {
          final seaCard = gameState.getSeaCardIndex(i);

          if (!seaCard.isOpened && (seaCard.suit.index <= 3)) {
            return true;
          }
        }

        break;
    }

    return false;
  }
}
