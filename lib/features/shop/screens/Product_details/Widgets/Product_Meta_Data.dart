import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/images/TCircularImages.dart';
import 'package:kkn_store/common/widgets/text/TBrand_title_Text_with_verify_Icon.dart';
import 'package:kkn_store/common/widgets/text/product_price_text.dart';
import 'package:kkn_store/common/widgets/text/product_title.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/enums.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final discount = product.salePrice > 0 
        ? ((product.price - product.salePrice) / product.price * 100).round() 
        : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & sale Price
        Row(
          children: [
            //seal Tag
            if (discount > 0)
              TRoundedContainer(
                radius: TSizes.sm,
                backgroundColor: TColors.secondary.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm,
                  vertical: TSizes.xs,
                ),
                child: Text(
                  '$discount%',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: TColors.black),
                ),
              ),
            if (discount > 0) const SizedBox(width: TSizes.spaceBtwItems),
            
            // Price
            if (product.salePrice > 0)
              Text(
                '₹${product.price}',
                style: Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            if (product.salePrice > 0) const SizedBox(width: TSizes.spaceBtwItems),
            
            TProductPriceText(
              price: product.salePrice > 0 ? product.salePrice.toString() : product.price.toString(), 
              isLarge: true
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Title
        TProductsTitleText(title: product.title),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            const TProductsTitleText(title: 'Stock :', smallSize: true),
            const SizedBox(width: TSizes.spaceBtwItems / 1.5),
            Text(
              product.stock > 0 ? 'In Stock' : 'Out of Stock', 
              style: Theme.of(context).textTheme.titleMedium!.apply(
                color: product.stock > 0 ? Colors.green : Colors.red
              )
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Brand
        if (product.brand != null)
          Row(
            children: [
              TCircularImage(
                image: product.brand!.image,
                isNetworkImage: true, // Assuming brand images are URLs
                dark: dark,
                width: 32,
                height: 32,
                overlayColor: dark ? TColors.white : TColors.black,
              ),
              TBrandTitleWithVerifiedIcon(
                title: product.brand!.name,
                brandTextSize: TextSizes.medium,
              ),
            ],
          ),
      ],
    );
  }
}
