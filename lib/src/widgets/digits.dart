import 'package:flutter/material.dart';

// 等幅で表示する
class Digits extends StatelessWidget {
  const Digits(
    this.chars, {
    super.key,
    this.charWidth = 12.0,
    this.style,
  });

  final String chars;
  final double charWidth;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min, // x
        children: [
          for (int i = 0; i < chars.length; i++)
            Container(
                alignment: Alignment.center,
                width: charWidth,
                child: Text(
                  chars[i],
                  style: style,
                ))
        ]);
  }
}
