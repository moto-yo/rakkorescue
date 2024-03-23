import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../dialog/sea_dlg.dart';
import '../widgets/dice_widget.dart';

class RollDice extends StatefulWidget {
  const RollDice({super.key});

  @override
  State<RollDice> createState() => _RollDiceState();
}

class _RollDiceState extends State<RollDice> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final _random = math.Random();
  final _dice = <int>[1, 1];
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 782),
    );

    _controller.addListener(() {
      setState(() {
        // 回転時の表示
        _dice[0] = 1 + _random.nextInt(6);
        _dice[1] = 1 + _random.nextInt(6);
      });
    });

    _animation = Tween<double>(begin: 0, end: 3 * math.pi).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 停止時の表示
        final gameState = Provider.of<GameState>(context, listen: false);

        _dice[0] = gameState.dice(0);
        _dice[1] = gameState.dice(1);

        // アニメーション完了時
        _isFinished = true;
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
      final dy = (math.sin(_animation.value)).abs() * 180;

      return GestureDetector(
        onTap: () {
          if (_isFinished) {
            // 遷移する
            final gameState = Provider.of<GameState>(context, listen: false);

            gameState.triggerDiceRolled();
          } else {
            // アニメーション開始
            if (!_controller.isAnimating) {
              _controller.forward();
            }
          }
        },
        child: Container(
          width: SeaDlg.screenSize.width,
          height: SeaDlg.screenSize.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: PlayImages.rollDiceBg,
              fit: BoxFit.contain,
            ),
          ),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 265),
                alignment: Alignment.topCenter,
                child: Text(
                  AppLocalizations.of(context)?.rollDice ?? 'rollDice', // 'さぁ行こう！',
                  style: const TextStyle(
                    color: Color(0xFF034682),
                    fontSize: 120 * 72 / 80,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 584 - dy),
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DiceWidget(n: _dice[0]),
                    const SizedBox(width: 20),
                    DiceWidget(n: _dice[1]),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
