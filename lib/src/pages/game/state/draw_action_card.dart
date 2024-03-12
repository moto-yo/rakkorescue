import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../sea_dlg.dart';
import '../tap_icon.dart';

class DrawActionCard extends StatefulWidget {
  const DrawActionCard({super.key});

  @override
  State<DrawActionCard> createState() => _DrawActionCardState();
}

class _DrawActionCardState extends State<DrawActionCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isStarted = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1382),
    );

    _controller.addListener(() {
      setState(() {});
    });

    _animation = Tween<double>(begin: 0, end: 2.0 * math.pi * 6).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // アニメーション完了時

        // 遷移する
        final gameState = Provider.of<GameState>(context, listen: false);

        gameState.triggerDrawedActionCard();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

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
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 47),
              alignment: Alignment.topCenter,
              child: Text(
                AppLocalizations.of(context)?.start1 ?? 'start1', // 'なにがでるかな？'
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 151),
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  // アニメーション開始
                  if (!_controller.isAnimating) {
                    _controller.forward();

                    _isStarted = true;
                  }
                },
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.00082)
                    ..rotateX(_animation.value),
                  alignment: FractionalOffset.center,
                  child: const Image(image: PlayImages.actionCardBack),
                ),
              ),
            ),
            Visibility(
              visible: !_isStarted,
              child: Container(
                margin: const EdgeInsets.only(top: 550),
                alignment: Alignment.topCenter,
                child: const TapIcon(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
