import 'package:flutter/material.dart';

import '../../../assets/play_images.dart';

// 指アイコンが上下してタップを促す
class TapIcon extends StatefulWidget {
  const TapIcon({super.key});

  @override
  State<TapIcon> createState() => _TapIconState();
}

class _TapIconState extends State<TapIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0.0, -0.2),
      end: const Offset(0.0, 0.2),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: const SizedBox(
        width: 160,
        height: 170,
        child: Image(image: PlayImages.tapIcon),
      ),
    );
  }
}
