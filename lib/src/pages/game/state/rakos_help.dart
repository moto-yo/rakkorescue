import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../mini_dlg.dart';

class RakosHelp extends StatelessWidget {
  const RakosHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return MiniDlg(
      AppLocalizations.of(context)?.rakkosHelp1 ?? 'rakkosHelp1', // 'とりのぞくゴミをタップしてください',
      bgImage: PlayImages.miniDlgBg,
    );
  }
}
