import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../dialog/sea_dlg.dart';

class HelpRakko extends StatelessWidget {
  const HelpRakko({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return Container(
        width: SeaDlg.screenSize.width,
        height: SeaDlg.screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: PlayImages.happyDlgBg,
            fit: BoxFit.contain,
          ),
        ),
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 53),
            alignment: Alignment.topCenter,
            child: Text(
              AppLocalizations.of(context)?.helpRakkos1Title ?? 'helpRakkos1Title', // 'やったね！',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 565),
            alignment: Alignment.topCenter,
            child: Text(
              AppLocalizations.of(context)?.helpRakkos1Body ?? 'helpRakkos1Body', // 'らっこをサーフボートにのせた！',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (0 < gameState.waitingRakkoN) {
                // 満員ダイアログを表示する
                gameState.triggerCannotHelpRakko();
              } else {
                // サイコロを振る に戻る
                gameState.triggerRollDice();
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: 777),
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
