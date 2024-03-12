import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/game_state.dart';
import '../../interfaces/state_type.dart';

import './state/choice_goal.dart';
import './state/choice_repair_boat.dart';

import './state/rakos_help_anim.dart';

// 🌊海ダイアログのレイアウト
class SeaMiniLongDlg extends StatelessWidget {
  const SeaMiniLongDlg({
    super.key,
    required this.gridWidth,
    required this.gridHeight,
    required this.space,
  });

  final double gridWidth;
  final double gridHeight;
  final Offset space;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: gridWidth,
      top: gridHeight * 5 + space.dy * 5,
      child: SizedBox(
        width: gridWidth * 4 + space.dx,
        height: gridHeight,
        child: const FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
          child: SeaDialogScreens(),
        ),
      ),
    );
  }
}

class SeaDialogScreens extends StatelessWidget {
  const SeaDialogScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      switch (gameState.stateType) {
        case StateType.rakosHelpAnim:
          return const RakosHelpAnim();

        case StateType.choiceGoal:
          return const ChoiceGoal();

        case StateType.choiceRepairBoat:
          return const ChoiceRepairBoat();

        default:
          return const SizedBox();
      }
    });
  }
}
