import 'package:flutter/material.dart';

import '../../assets/note_images.dart';

// らっこノート View
class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    // print("SettingsView.build()");

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffA2C2AC),
        image: DecorationImage(
          image: NoteImages.underdevelopment,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
