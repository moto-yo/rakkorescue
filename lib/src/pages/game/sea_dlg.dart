import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/game_state.dart';
import '../../interfaces/state_type.dart';

import './state/draw_action_card.dart';
import './state/drawed_action_card.dart';
import './state/limit_action_card.dart';
import './state/roll_dice.dart';
import './state/dice_same.dart';
import './state/choice_action_card.dart';

import './state/rakos_research_anim.dart';
import './state/success.dart';
import './state/success_anim.dart';
import './state/discover_rakko.dart';
import './state/miss_anim.dart';

import './state/round.dart';
import './state/help_rakko.dart';
import './state/cannot_help_rakko.dart';
import 'state/open_sea_card.dart';

import './state/repair_boat_anim.dart';

// 🌊海ダイアログのレイアウト
class SeaDlg extends StatelessWidget {
  const SeaDlg({
    super.key,
    required this.gridWidth,
    required this.gridHeight,
    required this.space,
  });

  final double gridWidth;
  final double gridHeight;
  final Offset space;

  // 仮想画面サイズ
  static const screenSize = Size(824.0, 986.0);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: gridWidth,
      top: gridHeight,
      child: SizedBox(
        width: gridWidth * 3 + space.dx * 4,
        height: gridHeight * 3 + space.dy * 4,
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
        case StateType.drawActionCard:
          return const DrawActionCard();

        case StateType.drawedActionCard:
          return const DrawedActionCard();

        case StateType.limitActionCard:
          return const LimitActionCard();

        case StateType.rollDice:
          return const RollDice();

        case StateType.diceSame:
          return const DiceSame();

        case StateType.choiceActionCard:
          return const ChoiceActionCard();

        case StateType.rakosResearchAnim:
          return const RakosResearchAnim();

        case StateType.success:
          return const Success();

        case StateType.successAnim:
          return const SuccessAnim();

        case StateType.discoverRakko:
          return const DiscoverRakko();

        case StateType.missAnim:
          return const MissAnim();

        case StateType.round:
          return const Round();

        case StateType.helpRakko:
          return const HelpRakko();

        case StateType.cannotHelpRakko:
          return const CannotHelpRakko();

        case StateType.openSeaCard:
          return const OpenSeaCard();

        case StateType.repairBoatAnim:
          return const RepairBoatAnim();

        default:
          return const SizedBox();
      }
    });
  }
}
