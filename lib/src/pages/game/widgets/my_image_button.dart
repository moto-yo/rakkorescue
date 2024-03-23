import 'package:flutter/material.dart';

class MyImageButton extends StatelessWidget {
  const MyImageButton({
    super.key,
    required this.image,
    required this.width,
    required this.height,
    this.margin,
    this.onTap,
    this.isDisable = false,
  });

  final AssetImage image;
  final double width;
  final double height;
  final EdgeInsetsGeometry? margin;
  final void Function()? onTap;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: GestureDetector(
        onTap: onTap,
        child: isDisable
            ? Image(
                image: image,
                width: width,
                height: height,
                color: Colors.grey,
                colorBlendMode: BlendMode.saturation,
              )
            : Image(
                image: image,
                width: width,
                height: height,
              ),
      ),
    );
  }
}
