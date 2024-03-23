import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../dialog/sea_dlg.dart';

class Round extends StatelessWidget {
  const Round({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return GestureDetector(
        onTap: () {
          // 遷移する
          gameState.triggerDrawActionCard();
        },
        child: SizedBox(
          width: SeaDlg.screenSize.width,
          height: SeaDlg.screenSize.height,
          child: Stack(
            children: [
              const Center(
                child: Image(
                  image: PlayImages.roundMark,
                  width: 789,
                  height: 789,
                ),
              ),
              Center(
                child: Text(
                  '${gameState.roundI}R',
                  style: const TextStyle(
                    fontSize: 320.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffa1624b),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
