import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../dialog/sea_dlg.dart';
import '../widgets/action_card_widget.dart';

class LimitActionCard extends StatelessWidget {
  const LimitActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return Container(
        width: SeaDlg.screenSize.width,
        height: SeaDlg.screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: PlayImages.seaDlgBg,
            fit: BoxFit.contain,
          ),
        ),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 32),
            child: Text(
              AppLocalizations.of(context)?.limitActionCard1 ?? 'limitActionCard1', // 'らっこの助けは 2つまで！',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Text(
            AppLocalizations.of(context)?.limitActionCard2 ?? 'limitActionCard2', // '捨てるものを 1つ選んでください',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          ...List.generate(gameState.actionCards.length, (i) {
            final actionCard = gameState.actionCards[i];

            return ActionCardWidget(
              actionCard: actionCard,
              actionCardUse: ActionCardUse.dialog,
              onTap: () {
                // 捨てるアクション カードを選択する
                gameState.triggerLimitActionCardAnim(i);
              },
            );
          })
        ]),
      );
    });
  }
}
