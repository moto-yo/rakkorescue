import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../dialog/mini_dlg.dart';

class RakosResearch extends StatelessWidget {
  const RakosResearch({super.key});

  @override
  Widget build(BuildContext context) {
    return MiniDlg(
      AppLocalizations.of(context)?.rakosResearch ?? 'rakosResearch', // '調べる波をタップしてください',
      bgImage: PlayImages.miniDlgBg,
    );
  }
}
