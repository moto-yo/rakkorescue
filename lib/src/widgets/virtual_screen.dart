import 'package:flutter/material.dart';

// 仮想画面サイズでレイアウトしたものを任意の画面サイズに収まるように拡大縮小する
class VirtualScreen extends StatelessWidget {
  const VirtualScreen({
    super.key,
    this.bgColor,
    this.width,
    this.height,
    this.child,
  });

  final Color? bgColor;
  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      width: double.infinity,
      height: double.infinity,
      // SizedBox = sizeだけの Container
      child: SizedBox(
        width: width, // 仮想画面サイズ
        height: height,
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
