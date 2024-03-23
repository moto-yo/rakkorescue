import 'package:flutter/material.dart';

import '../../../assets/play_images.dart';
import '../views/sea_dlg_view.dart';

class ChoiceRepairBoatSub extends StatelessWidget {
  const ChoiceRepairBoatSub({super.key});

  @override
  Widget build(BuildContext context) {
    return const SeaDlgView(
      bgImage: PlayImages.repairImg,
      width: 821,
      height: 336,
    );
  }
}
