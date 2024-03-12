import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../sea_dlg.dart';

class RepairBoatAnim extends StatelessWidget {
  const RepairBoatAnim({super.key});

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
            margin: const EdgeInsets.all(32),
            child: Text(
              AppLocalizations.of(context)?.repairBoards ?? 'repairBoards', // 'ボートを修理しました',
              style: const TextStyle(
                fontSize: 96.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // 遷移する
              gameState.triggerRollDice();
            },
            child: const Text(
              'OK',
              style: TextStyle(
                fontSize: 96.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ]),
      );
    });
  }
}
