import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../my_image_button.dart';
import '../sea_dlg_layout.dart';

class ChoiceRepairBoat extends StatelessWidget {
  const ChoiceRepairBoat({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return SeaDlgLayout(
        bgImage: PlayImages.miniLongDlgBg,
        width: 1107,
        height: 330,
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 33) + const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              AppLocalizations.of(context)?.choiceRepairBoat2 ?? 'choiceRepairBoat2', // '昆布でボートを修理する？',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Row(children: [
            MyImageButton(
              image: PlayImages.batuBtn,
              width: 306,
              height: 132,
              margin: const EdgeInsets.only(top: 26, left: 205),
              onTap: () {
                // 壊れたボート🛶を修理⛵️しない場合
                gameState.triggerRollDice();
              },
            ),
            MyImageButton(
              image: PlayImages.maruBtn,
              width: 306,
              height: 132,
              margin: const EdgeInsets.only(top: 26, right: 205),
              onTap: () {
                // 壊れたボート🛶を修理⛵️する場合
                gameState.triggerRepairBoat();
              },
            ),
          ]),
        ]),
      );
    });
  }
}
