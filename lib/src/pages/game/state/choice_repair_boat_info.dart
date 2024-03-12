import 'package:flutter/material.dart';

import '../../../assets/play_images.dart';
import '../sea_dlg_layout.dart';

class ChoiceRepairBoatSub extends StatelessWidget {
  const ChoiceRepairBoatSub({super.key});

  @override
  Widget build(BuildContext context) {
    return const SeaDlgLayout(
      bgImage: PlayImages.repairImg,
      width: 821,
      height: 336,
    );
  }
}
