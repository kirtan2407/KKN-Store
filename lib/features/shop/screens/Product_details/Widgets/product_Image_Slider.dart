import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shaps/curved_edgs/curved_edge_widgets.dart';
import '../../../../../common/widgets/icon/TCircular_Icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../Home/widgets/TPosterImageSet.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgeWidgets(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            // Main large image - FIXED VERSION
            SizedBox(
              height: 400,
              width: double.infinity, // Changed from 600 to full width
              child: Container(
                margin: const EdgeInsets.all(
                  TSizes.productImageRadius,
                ), // Changed padding to margin
                child: ClipRRect(
                  // Added ClipRRect for better image handling
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    TImages.nike_2,
                    fit:
                        BoxFit.cover, // This ensures image covers the full area
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),

            // Image Slider
            Positioned(
              bottom: 30,
              right: 0,
              left: 10,
              child: SizedBox(
                height: 75,
                child: ListView.separated(
                  separatorBuilder:
                      (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
                  itemCount: 9,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder:
                      (_, index) => TRoundedImage(
                        width: 75,
                        backgroundColor: dark ? TColors.dark : TColors.light,
                        border: Border.all(color: TColors.primaryColor),
                        padding: const EdgeInsets.all(TSizes.sm),
                        imageUrl: TImages.nike6,
                      ),
                ),
              ),
            ),

            // Appbar
            KknAppbar(
              showArrowBack: true,
              actions: [
                TCircularIcon(
                  dark: dark,
                  icon: Iconsax.heart5,
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
