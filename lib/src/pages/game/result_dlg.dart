import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../assets/play_images.dart';
import '../../state/game_state.dart';

import 'action_card_view.dart';
import 'sea_card_view.dart';
import 'sea_dlg.dart';

// 結果ダイアログ
class ResultDlg extends StatelessWidget {
  const ResultDlg({super.key, required this.title, required this.onClose});

  final String title;
  final Function onClose;

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
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              '${gameState.roundI}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${AppLocalizations.of(context)?.result1 ?? 'result1'} 🦦 ${gameState.waitingRakkoN}', // 救出できなかったラッコの数
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 42),
            ),
            Text(
              '${AppLocalizations.of(context)?.result2 ?? 'result2'} ${gameState.logActionCardN}', // 使った「らっこの手」 💪
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 42),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(gameState.logActionCardN, (i) {
                final actionCard = gameState.logActionCard(i);

                // print('logActionCard[$i] = $actionCard');

                return ActionCardView(
                  actionCard: actionCard,
                  actionCardUse: ActionCardUse.result,
                );
              }),
            ),
            Text(
              '${AppLocalizations.of(context)?.result3 ?? 'result3'} ${gameState.logRemoveDebriSetN}', // ゴミセットの数
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 42),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(gameState.logRemoveDebriSetN, (i) {
                final seaCards = gameState.logRemoveDebriSet(i);

                // print('logActionCard[$i] = $actionCard');

                return Column(children: [
                  ...seaCards.map((seaCard) {
                    return SeaCardView(seaCard: seaCard, seaCardUse: SeaCardUse.result);
                  }),
                ]);
              }),
            ),
            Text(
              '${AppLocalizations.of(context)?.result4 ?? 'result4'} ${gameState.logRemoveDebriN}', // ゴミとりした数
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 42),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(gameState.logRemoveDebriN, (i) {
                final seaCard = gameState.logRemoveDebri(i);

                // print('logActionCard[$i] = $actionCard');

                return SeaCardView(seaCard: seaCard, seaCardUse: SeaCardUse.result);
              }),
            ),
            Text(
              '${AppLocalizations.of(context)?.result5 ?? 'result5'} ${gameState.helpedRakkoN}', // 救出できたラッコの数 🦦
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 42),
            ),
            Text(
              'SCORE ${0}pt',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 42),
            ),
            ElevatedButton(
              onPressed: () {
                onClose();
              },
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 72),
              ),
            ),
          ]),
        ),
      );
    });
  }
}
