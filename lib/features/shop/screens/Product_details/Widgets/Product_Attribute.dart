import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/chicechip/choicechip.dart';
import 'package:kkn_store/common/widgets/text/product_price_text.dart';
import 'package:kkn_store/common/widgets/text/product_title.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TProductAttribute extends StatelessWidget {
  const TProductAttribute({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              /// Title, Price and Stock Status
              Row(
                children: [
                  const TSectionHeading(
                    title: 'Variation',
                    showActionButton: false,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          const TProductsTitleText(
                            title: 'Price : ',
                            smallSize: true,
                          ),

                          /// Actual Price
                          Text(
                            '₹${product.price}',
                            style: Theme.of(context).textTheme.titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),

                          /// Sale Price
                          TProductPriceText(price: product.salePrice > 0 ? product.salePrice.toString() : product.price.toString()),
                        ],
                      ),

                      ///Stock
                      Row(
                        children: [
                          const TProductsTitleText(
                            title: 'Stock : ',
                            smallSize: true,
                          ),
                          Text(
                            product.stock > 0 ? 'In Stock' : 'Out of Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          // const SizedBox(width: TSizes.spaceBtwItems),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              /// Variation Description
              TProductsTitleText(
                title: product.description ?? '',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// --- Attributes
        // TODO: Implement dynamic attributes based on product data
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Colors', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(
                  text: 'Black',
                  selected: true,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: 'White',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
          ],
        ),
      ],
    );
  }
}
