import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/play_images.dart';
import '../dialog/mini_dlg.dart';

class RepairBoat extends StatelessWidget {
  const RepairBoat({super.key});

  @override
  Widget build(BuildContext context) {
    return MiniDlg(
      AppLocalizations.of(context)?.repairBoat ?? 'repairBoat', // '使う昆布をタップしてください',
      bgImage: PlayImages.miniDlgBg,
    );
  }
}
