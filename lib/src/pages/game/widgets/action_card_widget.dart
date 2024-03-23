import 'package:flutter/material.dart';

import '../../../interfaces/action_card.dart';
import '../../../assets/play_images.dart';

enum ActionCardUse {
  dialog,
  info,
  result,
}

// アクション カード
class ActionCardWidget extends StatelessWidget {
  const ActionCardWidget({
    super.key,
    required this.actionCard,
    this.actionCardUse = ActionCardUse.dialog,
    this.isFront = true,
    this.isDisable = false,
    this.onTap,
  });

  final ActionCard actionCard;
  final ActionCardUse actionCardUse;
  final bool isFront; // 表面の場合 true
  final bool isDisable;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    AssetImage image;

    if (isFront) {
      switch (actionCard.action) {
        case ActionType.help:
          image = PlayImages.actionTypeHelps[actionCard.n - 1];

          break;

        case ActionType.surfing:
          image = PlayImages.actionTypeSurfing;

          break;

        case ActionType.research:
          image = PlayImages.actionTypeResearch;

          break;
      }
    } else {
      image = PlayImages.actionCardBack;
    }

    Size cardSize;

    switch (actionCardUse) {
      case ActionCardUse.dialog:
        cardSize = const Size(483 * 2 / 3, 365 * 2 / 3);

        break;

      case ActionCardUse.info:
        // PlayActionCardsViewの高さに依存するので SizedBoxは邪魔
        return GestureDetector(
          onTap: isDisable ? null : onTap,
          child: isFront && isDisable
              ? Image(
                  image: image,
                  color: Colors.grey,
                  colorBlendMode: BlendMode.saturation,
                )
              : Image(image: image),
        );

      case ActionCardUse.result:
        cardSize = const Size(180, 111);

        break;
    }

    return GestureDetector(
      onTap: isDisable ? null : onTap,
      child: SizedBox(
        width: cardSize.width,
        height: cardSize.height,
        child: isFront && isDisable
            ? Image(
                image: image,
                color: Colors.grey,
                colorBlendMode: BlendMode.saturation,
              )
            : Image(image: image),
      ),
    );
  }
}
