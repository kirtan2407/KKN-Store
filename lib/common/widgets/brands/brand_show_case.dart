// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/features/shop/screens/Store/widgets/TCard.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

import 'package:kkn_store/features/shop/models/brand_model.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({super.key, required this.dark, required this.images, required this.brand});

  final bool dark;
  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      showBorder: true,
      backgroundColor: Colors.transparent,
      borderColor: TColors.darkGrey,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          TBrandCard(dark: dark, showBorder: false, brand: brand),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// --- Categories --- ///
          Row(
            children:
                images
                    .map((image) => brandTopProductImageWidget(image, context))
                    .toList(),
          ),
        ],
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context) {
  return Expanded(
    child: TRoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(right: TSizes.sm),
      backgroundColor:
          THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
      child: Image(fit: BoxFit.contain, image: AssetImage(image)),
    ), // TRoundedContainer
  ); // Expanded
}
