import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/images/TCircularImages.dart';
import 'package:kkn_store/common/widgets/text/TBrand_title_Text_with_verify_Icon.dart';
import 'package:kkn_store/features/shop/models/brand_model.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/enums.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    required this.dark,
    required this.showBorder,
    required this.brand,
    this.onTap,
  });

  final bool dark;
  final bool showBorder;
  final BrandModel brand;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      ///container design
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            // Icon
            Flexible(
              child: TCircularImage(
                image: brand.image,
                isNetworkImage: true,
                backgroundcolor: Colors.transparent,
                overlayColor: dark ? TColors.white : TColors.black,
                dark: dark,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            /// --- Text ---
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TBrandTitleWithVerifiedIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '${brand.productsCount ?? 0} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
