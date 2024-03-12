import 'package:flutter/material.dart';

import '../../interfaces/sea_card.dart';
import '../../assets/play_images.dart';

import 'dice_view.dart';

enum SeaCardUse {
  board,
  result,
}

// 盤面・盤上の🌊海カード
class SeaCardView extends StatelessWidget {
  const SeaCardView({
    super.key,
    required this.seaCard,
    this.isBoroBoat = false,
    this.seaCardUse = SeaCardUse.board,
    this.isDisable = false,
    this.onTap,
    this.dice = 0,
    this.isSelected = false,
  });

  final SeaCard seaCard;
  final bool isBoroBoat;
  final SeaCardUse seaCardUse;
  final bool isDisable;
  final void Function()? onTap;
  final int dice;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    AssetImage image = PlayImages.hidden;

    if ((seaCard.suit != SeaSuit.rockyBeach) && (seaCard.suit != SeaSuit.hidden)) {
      if (seaCard.suit == SeaSuit.goal) {
        image = PlayImages.goal;
      } else if (seaCard.isOpened) {
        if (seaCard.suit.index < SeaSuit.club.index) {
          image = PlayImages.seaSuits[seaCard.suit.index][seaCard.n];
        } else if (seaCard.suit == SeaSuit.club) {
          image = PlayImages.club;
        } else {
          image = PlayImages.empty;
        }
      } else {
        if (isBoroBoat) {
          image = PlayImages.boroBoat;
        } else {
          image = PlayImages.waves[seaCard.isSurge ? 1 : 0];
        }
      }
    }

    Size cardSize;

    switch (seaCardUse) {
      case SeaCardUse.board:
        cardSize = const Size(376, 415);

        break;

      case SeaCardUse.result:
        cardSize = const Size(134 / 3, 148 / 3);

        break;
    }

    Widget? diceWidget;

    if (0 < dice) {
      diceWidget = Center(
        child: Transform.scale(
          scale: 0.618,
          child: DiceView(n: dice),
        ),
      );
    }

    Widget? widget;

    if (diceWidget != null) {
      widget = Stack(
        children: [
          Image(image: image),
          diceWidget,
        ],
      );
    } else {
      widget = Image(image: image);
    }

    Decoration? decoration;

    if (isSelected) {
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(21.0),
        border: Border.all(
          color: Colors.white,
          width: 6.0,
        ),
      );
    }

    return GestureDetector(
      onTap: isDisable ? null : onTap,
      child: Container(
        width: cardSize.width,
        height: cardSize.height,
        decoration: decoration,
        child: widget,
      ),
    );
  }
}
