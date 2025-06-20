import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/chicechip/choicechip.dart';
import 'package:kkn_store/common/widgets/text/product_price_text.dart';
import 'package:kkn_store/common/widgets/text/product_title.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TProductAttribute extends StatelessWidget {
  const TProductAttribute({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TRoundedContainer(
          padding: EdgeInsets.all(TSizes.md),
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
                            '₹1000',
                            style: Theme.of(context).textTheme.titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),

                          /// Sale Price
                          const TProductPriceText(price: '2000'),
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
                            'In Stock',
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
                title: """Ditch the laces and get outside.These kicks featur
Nike's revolutionary FlyEase technology,making 
on-and-off a breeze. With a heel that pivots open for a
totally hands-free entry, they're great for people with
limited mobility—or anyone who wants a quicker way to get going. . .""",
                smallSize: true,
                maxLines: 10,
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// --- Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(title: 'Colors', showActionButton: false),
            SizedBox(height: TSizes.spaceBtwItems / 2),
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
                TChoiceChip(
                  text: 'Blue',
                  selected: false,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: 'Gold',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(title: 'Sizes', showActionButton: false),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(
                  text: 'UK 3.5',
                  selected: false,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: 'UK 4',
                  selected: false,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: 'UK 4.5',
                  selected: false,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: 'UK 5',
                  selected: true,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: 'UK 5.5',
                  selected: false,
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  text: 'UK 6',
                  selected: false,
                  onSelected: (value) {},
                  
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
      ],
    );
  }
}
