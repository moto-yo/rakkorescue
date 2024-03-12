import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../my_image_button.dart';
import '../sea_dlg_layout.dart';

class ChoiceGoal extends StatelessWidget {
  const ChoiceGoal({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return SeaDlgLayout(
        bgImage: PlayImages.miniLongDlgBgBlue,
        width: 1086,
        height: 343,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)?.choiceGoal1 ?? 'choiceGoal1', // 'ゴールする!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 72.0,
                  ),
                ),
                const SizedBox(height: 4),
                MyImageButton(
                  image: PlayImages.goalBtn,
                  width: 361,
                  height: 133,
                  onTap: () {
                    if (0 < gameState.helpedRakkoN) {
                      // らっこを助けられた
                      gameState.triggerSuccess();
                    } else {
                      // らっこを助けられなかった
                      gameState.triggerMiss();
                    }
                  },
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)?.choiceGoal2 ?? 'choiceGoal2', // '続けて波乗り',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 72.0,
                  ),
                ),
                const SizedBox(height: 4),
                MyImageButton(
                  image: PlayImages.continueBtn,
                  width: 361,
                  height: 133,
                  onTap: () {
                    // 波乗り継続
                    gameState.triggerChoiceDice();
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
