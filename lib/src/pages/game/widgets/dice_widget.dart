import 'package:flutter/material.dart';

import '../../../assets/play_images.dart';

// 🎲サイコロ
class DiceWidget extends StatelessWidget {
  const DiceWidget({super.key, required this.n});

  final int n;

  @override
  Widget build(BuildContext context) {
    return Image(image: PlayImages.dices[n - 1]);
  }
}
