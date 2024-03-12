import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../../../state/game_state.dart';

import '../sea_dlg.dart';

class DiscoverRakko extends StatelessWidget {
  const DiscoverRakko({super.key});

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
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(32),
            child: Text(
              AppLocalizations.of(context)?.discoverRakkosTitle ?? 'discoverRakkosTitle', // '＼おめでとう！新しい発見！／',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            AppLocalizations.of(context)?.discoverRakkosBody ?? 'discoverRakkosBody', // 'あなたが助けたらっこは、らっこの研究ノートで確認できます。どんどん助けて詳しくなりましょう！',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          ElevatedButton(
            onPressed: () {
              // 遷移する
              gameState.triggerTitle();
            },
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ]),
      );
    });
  }
}
