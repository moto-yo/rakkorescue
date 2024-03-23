import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../views/sea_dlg_view.dart';

// ボロボートの場合、ダイアログを表示する
class RakosHelpAnim extends StatelessWidget {
  const RakosHelpAnim({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return SeaDlgView(
        bgImage: PlayImages.miniLongDlgBg,
        width: 1107,
        height: 330,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60, left: 56),
              alignment: Alignment.topLeft,
              width: 810,
              height: 194,
              child: Text(
                AppLocalizations.of(context)?.rakkosHelpAnim ?? 'rakkosHelpAnim', // '壊れたボードを入手！昆布で修理すると使えます',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 95, right: 46),
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  if (gameState.actionCards.isNotEmpty) {
                    // アクション カードがある場合
                    gameState.triggerChoiceActionCard();
                  } else {
                    // アクション カードが無い場合
                    gameState.triggerActioned();
                  }
                },
                child: const Image(
                  image: PlayImages.okBtn,
                  width: 151,
                  height: 151,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
