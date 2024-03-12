import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/game_state.dart';

import '../result_dlg.dart';

class SuccessAnim extends StatelessWidget {
  const SuccessAnim({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      return ResultDlg(
          title: "Success!",
          onClose: () {
            // 乱数: { 0, 1 }
            var random = math.Random();
            final result = random.nextInt(2); // 0 ≦ rnd < 2

            if (result == 0) {
              // 新しいらっこを発見しなかった場合
              gameState.triggerTitle();
            } else {
              // 新しいらっこを発見した場合
              gameState.triggerDiscoverRakko();
            }
          });
    });
  }
}
