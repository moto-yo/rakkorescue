import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';
import '../../../interfaces/action_card.dart';

import '../my_image_button.dart';
import '../sea_dlg.dart';
import '../action_card_view.dart';

class ChoiceActionCard extends StatefulWidget {
  const ChoiceActionCard({super.key});

  @override
  State<ChoiceActionCard> createState() => _ChoiceActionCardState();
}

class _ChoiceActionCardState extends State<ChoiceActionCard> {
  ActionCard? _selectedActionCard;
  int _selectedActionCardI = -1;

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
        child: (_selectedActionCard == null)
            ? Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(32),
                    child: Text(
                      AppLocalizations.of(context)?.choiceActionCard ?? 'choiceActionCard', // '使うアクション カードを選択してね',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(gameState.actionCards.length, (i) {
                        final actionCard = gameState.actionCards[i];

                        return ActionCardView(
                          actionCard: actionCard,
                          actionCardUse: ActionCardUse.dialog,
                          isDisable: !actionCard.canUse(gameState),
                          onTap: () {
                            // 再描画する
                            setState(() {
                              // アクション カードを選択する
                              _selectedActionCard = actionCard;
                              _selectedActionCardI = i;
                            });
                          },
                        );
                      }),
                      const SizedBox(height: 48),
                      MyImageButton(
                        image: PlayImages.skipBtn,
                        width: 246,
                        height: 165,
                        onTap: (0 <= gameState.choicedActionCardI)
                            ? null
                            : () {
                                // 遷移する
                                gameState.triggerActioned();
                              },
                      ),
                    ],
                  ),
                ],
              )
            : Builder(builder: (BuildContext context) {
                final actionCard = _selectedActionCard!;
                final titles = <String>[
                  AppLocalizations.of(context)?.useTrashPickupTitle ?? 'useTrashPickupTitle', // '「ゴミとり」'
                  AppLocalizations.of(context)?.useSurfAgainTitle ?? 'useSurfAgainTitle', // '「波乗りアゲイン」',
                  AppLocalizations.of(context)?.useSeaOtterSearchTitle ?? 'useSeaOtterSearchTitle', // '「らっこリサーチ」',
                ];

                final title = titles[actionCard.action.index];
                final body = actionCard.getBody(context);

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
                    child: Stack(children: [
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(top: 0, right: 0),
                          alignment: Alignment.topRight,
                          child: const Image(
                            image: PlayImages.closeBtn,
                            width: 147,
                            height: 147,
                          ),
                        ),
                        onTap: () {
                          // 再描画する
                          setState(() {
                            // アクション カードを選択解除する
                            _selectedActionCard = null;
                            _selectedActionCardI = -1;
                          });
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 151),
                        alignment: Alignment.topCenter,
                        child: ActionCardView(
                          actionCard: actionCard,
                          actionCardUse: ActionCardUse.dialog,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 466) + const EdgeInsets.symmetric(horizontal: 24),
                          alignment: Alignment.topCenter,
                          child: Column(children: [
                            Text(
                              title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              body,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ])),
                      GestureDetector(
                        onTap: () {
                          switch (actionCard.action) {
                            case ActionType.help:
                              // らっこの手助け💪で取り除くゴミを選ぶ
                              gameState.triggerRakosHelp(_selectedActionCardI);

                              break;

                            case ActionType.surfing:
                              // 波乗りアゲインを実行する
                              gameState.triggerSurfingAgainAnim(_selectedActionCardI);

                              break;

                            case ActionType.research:
                              // らっこリサーチで調べる🌊海カードを選ぶ
                              gameState.triggerRakosResearch(_selectedActionCardI);

                              break;
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 774),
                          alignment: Alignment.topCenter,
                          child: const Image(
                            image: PlayImages.maruBtn,
                            width: 322,
                            height: 167,
                          ),
                        ),
                      ),
                    ]),
                  );
                });
              }),
      );
    });
  }
}
