import 'package:flutter/material.dart';

import '../views/sea_dlg_view.dart';

class MiniDlg extends StatelessWidget {
  const MiniDlg(
    this.body, {
    super.key,
    required this.bgImage,
    this.textStyle,
  });

  final String body;
  final AssetImage bgImage;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SeaDlgView(
      bgImage: bgImage,
      width: 843,
      height: 336,
      child: Container(
        margin: const EdgeInsets.only(top: 48) + const EdgeInsets.symmetric(horizontal: 84),
        width: 656,
        child: Text(
          body,
          textAlign: TextAlign.center,
          style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
