import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../my_image_button.dart';
import '../sea_dlg_layout.dart';

class RemoveDebri extends StatelessWidget {
  const RemoveDebri({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return SeaDlgLayout(
        bgImage: PlayImages.miniLongDlgBg,
        width: 1107,
        height: 330,
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 36) + const EdgeInsets.symmetric(horizontal: 56),
            child: Text(
              AppLocalizations.of(context)?.removeDebris ?? 'removeDebris', // 'このセットでゴミとり',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Row(children: [
            MyImageButton(
              image: PlayImages.maruBtn,
              width: 374,
              height: 160,
              margin: const EdgeInsets.only(top: 12, left: 106),
              onTap: () {
                // 役でゴミを取り除く, roles[index]
                gameState.triggerRemoveDebriAnim(gameState.removeDebriRoleI);
              },
            ),
            MyImageButton(
              image: PlayImages.nextBtn,
              width: 250,
              height: 160,
              margin: const EdgeInsets.only(top: 12, right: 76),
              onTap: () {
                // ターン終了する
                gameState.triggerRollDice();
              },
            ),
          ]),
        ]),
      );
    });
  }
}
