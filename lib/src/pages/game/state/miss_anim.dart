import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/game_state.dart';

import '../result_dlg.dart';

class MissAnim extends StatelessWidget {
  const MissAnim({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return ResultDlg(
        title: "Miss...",
        onClose: () {
          // 遷移する
          gameState.triggerTitle();
        },
      );
    });
  }
}
