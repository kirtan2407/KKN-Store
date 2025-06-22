
import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/text/TBrand_title_Text_with_verify_Icon.dart';
import 'package:kkn_store/common/widgets/text/product_title.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Product Image
        TRoundedImage(
          imageUrl: TImages.nike_1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor:
              THelperFunctions.isDarkMode(context)
                  ? TColors.darkerGrey
                  : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
    
        /// Title, Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleWithVerifiedIcon(title: 'Nike'),
              Flexible(
                child: TProductsTitleText(
                  title: 'Nike Go FlyEase',
                  maxLines: 1,
                ),
              ),
    
              /// Attribute
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Color: ',
                      style:
                          Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: 'Black & White',
                      style:
                          Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: ' | Size: ',
                      style:
                          Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: 'UK 5',
                      style:
                          Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
