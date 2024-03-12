import 'package:flutter/material.dart';

import '../../assets/play_images.dart';

import 'play_layout.dart';

// プレイ画面
class PlayView extends StatelessWidget {
  const PlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: PlayImages.bg,
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(child: PlayLayout()),
    );
  }
}
