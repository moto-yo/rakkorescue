import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../dialog/sea_dlg.dart';

class CannotHelpRakko extends StatelessWidget {
  const CannotHelpRakko({super.key});

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
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 57),
            alignment: Alignment.topCenter,
            child: Text(
              '❌ ${AppLocalizations.of(context)?.helpRakkos2Title ?? 'helpRakkos2Title'} ❌', // '❌ 満員！ ❌',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 64.0,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 160),
            alignment: Alignment.topCenter,
            child: Text(
              AppLocalizations.of(context)?.helpRakkos2Body ?? 'helpRakkos2Body', // 'これ以上のりません。追加ボートが必要です。',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 472),
            alignment: Alignment.topCenter,
            width: 687,
            height: 278,
            child: const Image(image: PlayImages.repairImg),
          ),
          GestureDetector(
            onTap: () {
              // 遷移する
              gameState.triggerRollDice();
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
