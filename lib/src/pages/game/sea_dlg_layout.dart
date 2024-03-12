import 'package:flutter/material.dart';

class SeaDlgLayout extends StatelessWidget {
  const SeaDlgLayout({
    super.key,
    required this.bgImage,
    required this.width,
    required this.height,
    this.child,
  });

  final AssetImage bgImage;
  final double width;
  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: bgImage,
          fit: BoxFit.contain,
        ),
      ),
      child: child,
    );
  }
}
