import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../dialog/mini_dlg.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return GestureDetector(
        onTap: () {
          // 遷移する
          gameState.triggerMiss();
        },
        child: MiniDlg(
          AppLocalizations.of(context)?.gameover ?? 'gameover', // '同じ種類のゴミが 3つ揃ってしまった!',
          bgImage: PlayImages.miniDlgBgRed,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 59.0,
          ),
        ),
      );
    });
  }
}
