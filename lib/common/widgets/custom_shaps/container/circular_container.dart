import 'package:flutter/material.dart';
import 'package:kkn_store/utils/constants/colors.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.backgroundColor = TColors.white,
    this.radius = 400,
    this.padding = 0,
    this.child, 
    this.margin,
  });

  final double? width;
  final double? height;
  final Color backgroundColor;
  final double radius;
  final double padding;
  final Widget? child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
