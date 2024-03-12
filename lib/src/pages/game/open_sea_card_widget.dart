import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rakkorescue/src/interfaces/sea_card.dart';

import '../../assets/play_images.dart';
import '../../state/game_state.dart';

import 'sea_card_view.dart';
import 'sea_dlg.dart';

class OpenSeaCardWidget extends StatefulWidget {
  const OpenSeaCardWidget({super.key, required this.seaCard, required this.onTap});

  final SeaCard seaCard;
  final void Function() onTap;

  @override
  State<OpenSeaCardWidget> createState() => _OpenSeaCardState();
}

class _OpenSeaCardState extends State<OpenSeaCardWidget> with SingleTickerProviderStateMixin {
  SeaCard get _seaCard => widget.seaCard;

  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isFinished = false;

  @override
  void initState() {
    super.initState();

    if (_seaCard.isOpened) {
      _isFinished = true;
    } else {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 618),
      );

      _controller.addListener(() {
        setState(() {
          if (_animation.value < 0.5 * math.pi) {
            // 🌊盤面の海カードを開く
            if (_seaCard != GameState.seaCardEmpty) {
              _seaCard.isOpened = true;
            }
          }
        });
      });

      _animation = Tween<double>(begin: math.pi, end: 0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInBack,
        ),
      );

      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // アニメーション完了時
          _isFinished = true;
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, gameState, _) {
      final titles = [
        [
          AppLocalizations.of(context)?.seaHeart0Title ?? 'seaHeart0Title',
          AppLocalizations.of(context)?.seaHeart1Title ?? 'seaHeart1Title',
          AppLocalizations.of(context)?.seaHeart2Title ?? 'seaHeart2Title',
          AppLocalizations.of(context)?.seaHeart3Title ?? 'seaHeart3Title',
          AppLocalizations.of(context)?.seaHeart4Title ?? 'seaHeart4Title',
        ],
        [
          AppLocalizations.of(context)?.seaSpade0Title ?? 'seaSpade0Title',
          AppLocalizations.of(context)?.seaSpade1Title ?? 'seaSpade1Title',
          AppLocalizations.of(context)?.seaSpade2Title ?? 'seaSpade2Title',
          AppLocalizations.of(context)?.seaSpade3Title ?? 'seaSpade3Title',
          AppLocalizations.of(context)?.seaSpade4Title ?? 'seaSpade4Title',
        ],
        [
          AppLocalizations.of(context)?.seaDiamond0Title ?? 'seaDiamond0Title',
          AppLocalizations.of(context)?.seaDiamond1Title ?? 'seaDiamond1Title',
          AppLocalizations.of(context)?.seaDiamond2Title ?? 'seaDiamond2Title',
          AppLocalizations.of(context)?.seaDiamond3Title ?? 'seaDiamond3Title',
          AppLocalizations.of(context)?.seaDiamond4Title ?? 'seaDiamond4Title',
        ],
      ];

      String title = "";
      String body = "";

      switch (_seaCard.suit) {
        case SeaSuit.heart:
        case SeaSuit.spade:
        case SeaSuit.diamond:
          title = titles[_seaCard.suit.index][_seaCard.n];
          body = (_seaCard.n == 0) ? (AppLocalizations.of(context)?.seaCard0Body ?? 'seaCard0Body') : (AppLocalizations.of(context)?.seaCardBody ?? 'seaCardBody');

          break;

        case SeaSuit.club:
          title = AppLocalizations.of(context)?.seaKelpForestTitle ?? 'seaKelpForestTitle';
          body = AppLocalizations.of(context)?.seaKelpForestBody ?? 'seaKelpForestBody';

          break;

        default:
          break;
      }

      return Container(
        width: SeaDlg.screenSize.width,
        height: SeaDlg.screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: PlayImages.seaDlgBg,
            fit: BoxFit.contain,
          ),
        ),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 87),
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  if (!_isFinished) {
                    // アニメーション開始
                    if (!_controller.isAnimating) {
                      _controller.forward();
                    }
                  }
                },
                child: _isFinished
                    ? SeaCardView(
                        seaCard: _seaCard,
                        isBoroBoat: gameState.openSeaCardIsBoroBoat,
                      )
                    : Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.00082)
                          ..rotateY(_animation.value),
                        alignment: FractionalOffset.center,
                        child: SeaCardView(
                          seaCard: _seaCard,
                          isBoroBoat: gameState.openSeaCardIsBoroBoat,
                        ),
                      ),
              ),
            ),
            (_isFinished
                ? Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 543),
                        alignment: Alignment.topCenter,
                        child: Text(
                          title, // '釣り針: 猟具ゴミ1'
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 639) + const EdgeInsets.symmetric(horizontal: 24),
                        alignment: Alignment.topCenter,
                        child: Text(
                          body, // '同じマークのゴミ3つで波乗り終了'
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    ],
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 639) + const EdgeInsets.symmetric(horizontal: 24),
                    alignment: Alignment.topCenter,
                    child: Text(
                      AppLocalizations.of(context)?.seaCardBody ?? 'seaCardBody', // '同じマークのゴミ3つで波乗り終了'
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )),
            Visibility(
              visible: _isFinished,
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  margin: const EdgeInsets.only(top: 790),
                  alignment: Alignment.topCenter,
                  child: const Image(
                    image: PlayImages.okBtn,
                    width: 151,
                    height: 151,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
