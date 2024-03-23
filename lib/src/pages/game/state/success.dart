import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../dialog/sea_dlg.dart';

class Success extends StatelessWidget {
  const Success({super.key});

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
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.all(32),
              child: Text(
                AppLocalizations.of(context)?.successRescued ?? 'successRescued', // 'レスキュー せいこう！！',
                style: const TextStyle(
                  fontSize: 96.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)?.success ?? 'success', // 'らっこの手当てをしています...',
              style: const TextStyle(
                fontSize: 96.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // 遷移する
                gameState.triggerSuccessAnim();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 96.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ]),
        ),
      );
    });
  }
}
