import 'package:flutter/material.dart';

import '../../assets/settings_images.dart';

// ユーザー設定 View
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // print("SettingsView.build()");

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        image: DecorationImage(
          image: SettingsImages.underdevelopment,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
