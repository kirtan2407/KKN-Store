
import 'package:flutter/material.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.width = 350,
    this.height = 250,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.fit = BoxFit.cover,
    this.backgroundColor = TColors.light,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = TSizes.md,
  });

  final double width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final BoxFit? fit;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius:
              applyImageRadius ? BorderRadius.circular(borderRadius) : null,
        ),
        clipBehavior: Clip.antiAlias, // ensures the image follows radius
        child: ClipRRect(
          borderRadius:
              applyImageRadius
                  ? BorderRadius.circular(borderRadius)
                  : BorderRadius.zero,
          child: Image(
            image:
                isNetworkImage
                    ? NetworkImage(imageUrl)
                    : AssetImage(imageUrl) as ImageProvider,
            fit: fit,
          ),
        ),
      ),
    );
  }
}
