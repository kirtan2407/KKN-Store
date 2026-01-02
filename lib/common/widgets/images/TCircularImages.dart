// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    required this.dark,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundcolor,
    this.width = 60,
    this.padding = TSizes.sm,
    this.height = 60,
  });

  final bool dark;
  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundcolor;
  final double width, padding, height;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),

      decoration: BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
      child: Center(
        child: isNetworkImage
            ? ClipOval(
                child: Image.network(
                  image,
                  fit: fit,
                  width: width,
                  height: height,
                  color: overlayColor,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, color: dark ? TColors.white : TColors.black);
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              )
            : Image(
                fit: fit,
                image: AssetImage(image),
                color: overlayColor,
              ),
      ),
      ),
    );
  }
}
