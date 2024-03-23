import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../widgets/dice_widget.dart';
import '../dialog/sea_dlg.dart';

class DiceSame extends StatelessWidget {
  const DiceSame({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return GestureDetector(
        onTap: () {
          // 遷移する
          gameState.triggerRollDice();
        },
        child: Container(
          width: SeaDlg.screenSize.width,
          height: SeaDlg.screenSize.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: PlayImages.sameDiceDlgBg,
              fit: BoxFit.contain,
            ),
          ),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 265) + const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.topCenter,
                child: Text(
                  AppLocalizations.of(context)?.diceSame ?? 'diceSame', // '助けを求める動物がもう一匹やってきた！',
                  style: const TextStyle(
                    color: Color(0xFF034682),
                    fontSize: 213 / 2 * 72 / 80,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 584),
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DiceWidget(n: gameState.dice(0)),
                    const SizedBox(width: 20),
                    DiceWidget(n: gameState.dice(1)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
