import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/icon/TCircular_Icon.dart';
import 'package:kkn_store/common/widgets/text/TBrand_title_Text_with_verify_Icon.dart';
import 'package:kkn_store/common/widgets/text/product_price_text.dart';
import 'package:kkn_store/common/widgets/text/product_title.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        // boxShadow: [TShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color:
            THelperFunctions.isDarkMode(context)
                ? TColors.darkerGrey
                : TColors.softGrey,
      ),
      child: Row(
        children: [
          ///Thambnail
          TRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                //thambnail image
                SizedBox(
                  height: 120,
                  width: 120,
                  child: const TRoundedImage(
                    imageUrl: TImages.nike1,
                    applyImageRadius: true,
                  ),
                ),

                /// --- Seal Tag ---
                Positioned(
                  top: 12,
                  left: 12,
                  child: TRoundedContainer(
                    radius: TSizes.sm,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.sm,
                      vertical: TSizes.xs,
                    ),
                    child: Text(
                      '25%',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge!.copyWith(color: TColors.black),
                    ),
                  ),
                ),

                /// --- Favourite Icon Button ---
                Positioned(
                  top: 0,
                  right: 0,
                  child: TCircularIcon(
                    icon: Iconsax.heart5,
                    color: Colors.red,
                    dark: dark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),

          //Details
          SizedBox(
            width: 172,
            child: Padding(
              padding: EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductsTitleText(
                        title: '''Nike Go FlyEas
Women's Easy On/Off Shoes''',
                        smallSize: true,
                      ),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      TBrandTitleWithVerifiedIcon(title: 'Nike'),
                    ],
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: const TProductPriceText(price: '11895 - 12995'),
                      ),

                      /// Add to cart button
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomRight: Radius.circular(
                              TSizes.productImageRadius,
                            ),
                          ),
                        ),
                        child: const SizedBox(
                          width: TSizes.iconLg * 1.2,
                          height: TSizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(Iconsax.add, color: TColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
