import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../sea_dlg.dart';
import '../action_card_view.dart';

class DrawedActionCard extends StatelessWidget {
  const DrawedActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      final actionCard = gameState.actionCards[gameState.actionCards.length - 1];
      final titles = <String>[
        AppLocalizations.of(context)?.trashPickupTitle ?? 'trashPickupTitle', // '「ゴミとり」GET!'
        AppLocalizations.of(context)?.surfAgainTitle ?? 'surfAgainTitle', // '「波乗りアゲイン」GET!',
        AppLocalizations.of(context)?.seaOtterSearchTitle ?? 'seaOtterSearchTitle', // '「らっこリサーチ」GET!',
      ];

      final title = titles[actionCard.action.index];
      var body = actionCard.getBody(context);

      return Container(
        width: SeaDlg.screenSize.width,
        height: SeaDlg.screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: PlayImages.seaDlgBg,
            fit: BoxFit.contain,
          ),
        ),
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.all(47),
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 151),
            alignment: Alignment.topCenter,
            child: ActionCardView(
              actionCard: actionCard,
              actionCardUse: ActionCardUse.dialog,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 506),
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 644,
              height: 260,
              child: Text(
                body,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (3 <= gameState.actionCards.length) {
                // アクション カードを 1枚選んで捨てる
                gameState.triggerLimitActionCard();
              } else if (gameState.roundI == 1) {
                // ラウンド開始
                gameState.triggerRollDice();
              } else {
                // ラウンド継続
                gameState.triggerMoveForward();
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: 782),
              alignment: Alignment.topCenter,
              child: const Image(
                image: PlayImages.okBtn,
                width: 151,
                height: 151,
              ),
            ),
          ),
        ]),
      );
    });
  }
}
