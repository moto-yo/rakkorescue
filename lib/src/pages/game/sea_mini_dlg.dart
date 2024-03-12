import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/game_state.dart';
import '../../interfaces/state_type.dart';

import './state/choice_dice.dart';
import './state/game_over.dart';
import './state/remove_debri.dart';

import './state/choice_repair_boat_info.dart';
import './state/repair_boat.dart';

import 'state/rakos_help.dart';
import 'state/rakos_research.dart';

// 🌊海ダイアログのレイアウト
class SeaMiniDlg extends StatelessWidget {
  const SeaMiniDlg({
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
      top: gridHeight * 3 + space.dy * 2,
      child: SizedBox(
        width: gridWidth * 3 + space.dx * 4,
        height: gridHeight + space.dy * 2,
        child: const FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
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
        case StateType.rakosHelp:
          return const RakosHelp();

        case StateType.rakosResearch:
          return const RakosResearch();

        case StateType.choiceDice:
          return const ChoiceDice();

        case StateType.gameOver:
          return const GameOver();

        case StateType.removeDebri:
          return const RemoveDebri();

        case StateType.choiceRepairBoat:
          return const ChoiceRepairBoatSub();

        case StateType.repairBoat:
          return const RepairBoat();

        default:
          return const SizedBox();
      }
    });
  }
}
