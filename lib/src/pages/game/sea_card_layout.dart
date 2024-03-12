import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../interfaces/sea_card.dart';
import '../../interfaces/state_type.dart';
import '../../interfaces/role_card.dart';
import '../../state/game_state.dart';

import 'sea_card_view.dart';

// 盤面・盤上の🌊海カード
class SeaCardLayout extends StatelessWidget {
  const SeaCardLayout({
    super.key,
    required this.index,
  });

  final int index;

  static final _hiddenSeaCard = SeaCard(SeaSuit.hidden, 22, false, false); // 空の盤上, ボロボート置き場, 下ダイアログ領域

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, _) {
        SeaCard seaCard = _hiddenSeaCard;

        if (index == -1) {
          // スタート地点
          seaCard = SeaCard(SeaSuit.goal, -1, true, false);
        } else if (index < 16) {
          // 周回ゴミ
          seaCard = gameState.getSeaCardIndex(index);
        } else if (index < 22) {
          // 中央ゴミ
          final i = index - 16;
          final x = i % 2;
          final y = i ~/ 2;
          const seaSuits = <SeaSuit>[
            SeaSuit.heart, //   16, 17 | i=0,1 | y=0 | x=0,1
            SeaSuit.spade, //   18, 19 | i=2,3 | y=1 | x=0,1
            SeaSuit.diamond, // 20, 21 | i=4,5 | y=2 | x=0,1
          ];

          final seaSuit = seaSuits[y];
          final seaCards = gameState.tableCards.where((seaCard) => seaCard.suit == seaSuit).toList();

          if (x < seaCards.length) {
            seaCard = seaCards[x];
          }
        }

        // print('seaCard[$index] = {id: ${seaCard.id}, suit: ${seaCard.suit}, n: ${seaCard.n}, isOpened: ${seaCard.isOpened}, isSurge: ${seaCard.isSurge}}');

        final diceIs = <int>[
          (gameState.surfboardI + gameState.dice(0)) % 16,
          (gameState.surfboardI + gameState.dice(1)) % 16,
        ];

        // onTap()が有効の場合 true
        bool isEnable = false;

        if ((0 <= index) && (index < 22) && (seaCard != _hiddenSeaCard)) {
          switch (gameState.stateType) {
            case StateType.rakosHelp:
              {
                final actionCard = gameState.actionCards[gameState.choicedActionCardI];

                isEnable = 0 <= gameState.debriCards.indexWhere((roleCard) => roleCard.id == seaCard.id && seaCard.n <= actionCard.n);
              }

              break;

            case StateType.rakosResearch:
              // サイコロの目の海カードを調べる
              isEnable = ((gameState.surfboardI + gameState.dice(0)) % 16 == index) || ((gameState.surfboardI + gameState.dice(1)) % 16 == index);

              // print("rakosResearch: isEnable=$isEnable");

              break;

            case StateType.choiceDice:
              isEnable = (index == diceIs[0]) || (index == diceIs[1]);

              break;

            case StateType.removeDebri:
              outerLoop:
              for (Role role in gameState.roles) {
                for (RoleCard roleCard in role.cards) {
                  if (roleCard.id == seaCard.id) {
                    isEnable = true;

                    break outerLoop;
                  }
                }
              }

              break;

            case StateType.repairBoat:
              isEnable = (seaCard.suit == SeaSuit.club) && seaCard.isOpened;

              break;

            default:
              break;
          }
        }

        int dice = -1;

        if ((gameState.stateType == StateType.choiceDice) || (gameState.stateType == StateType.rakosResearch)) {
          for (int i = 0; i < 2; i++) {
            if (index == diceIs[i]) {
              dice = gameState.dice(i);
            }
          }
        }

        return SeaCardView(
          seaCard: seaCard,
          isBoroBoat: index == 4,
          isDisable: !isEnable,
          onTap: () {
            switch (gameState.stateType) {
              case StateType.rakosHelp:
                // 取り除くゴミを選択する
                gameState.triggerRakosHelpAnim(seaCard.id);

                break;

              case StateType.rakosResearch:
                // 調べる🌊海カードを選択する
                gameState.triggerRakosResearchAnim(seaCard.id);

                break;

              case StateType.choiceDice:
                for (int i = 0; i < 2; i++) {
                  if (index == diceIs[i]) {
                    // 遷移する
                    gameState.triggerDiceChoiced(i);
                  }
                }

                break;

              case StateType.removeDebri:
                // ゴミを取り除く役を選択する
                gameState.removeDebriRoleI = -1;

                outerLoop:
                for (int i = 0; i < gameState.roles.length; i++) {
                  int j = (gameState.removeDebriRoleI + 1 + i) % gameState.roles.length;
                  Role role = gameState.roles[j];

                  for (RoleCard roleCard in role.cards) {
                    if (roleCard.id == seaCard.id) {
                      gameState.removeDebriRoleI = j;

                      break outerLoop;
                    }
                  }
                }

                // 遷移しない

                break;

              case StateType.repairBoat:
                // 使用する昆布カードを選択する
                gameState.triggerRepairBoatAnim(seaCard.id);

                break;

              default:
                break;
            }
          },
          dice: dice,
          isSelected: (gameState.stateType == StateType.removeDebri) && isEnable,
        );
      },
    );
  }
}
