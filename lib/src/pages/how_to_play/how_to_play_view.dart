import 'package:flutter/material.dart';

import '../../assets/how_to_play_images.dart';

// あそびかた View
class HowToPlayView extends StatelessWidget {
  const HowToPlayView({super.key});

  @override
  Widget build(BuildContext context) {
    // print("SettingsView.build()");

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffECE3CE),
        image: DecorationImage(
          image: HowToPlayImages.underdevelopment,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
