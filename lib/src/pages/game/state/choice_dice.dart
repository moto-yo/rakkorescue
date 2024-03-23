import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../dialog/mini_dlg.dart';

class ChoiceDice extends StatelessWidget {
  const ChoiceDice({super.key});

  @override
  Widget build(BuildContext context) {
    return MiniDlg(
      AppLocalizations.of(context)?.choiceDice ?? 'choiceDice', // 'どちらの波にのりますか？',
      bgImage: PlayImages.miniDlgBgGreen,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 82.0,
      ),
    );
  }
}
