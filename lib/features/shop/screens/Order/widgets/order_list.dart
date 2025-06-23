import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.separated(
      itemCount: 9,
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder:
          (_, index) => TRoundedContainer(
            showBorder: true,
            padding: EdgeInsets.all(TSizes.md),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                // row1
                Row(
                  children: [
                    // 1.Icon
                    const Icon(Iconsax.ship),
                    SizedBox(width: TSizes.defaultSpace),

                    // 2.Status & date
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Processing',
                            style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: TColors.primaryColor,
                              fontWeightDelta: 1,
                            ),
                          ),
                          Text(
                            '07 Nov 2024',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Iconsax.arrow_right_34, size: TSizes.iconSm),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                // row2
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          // 1.Icon
                          const Icon(Iconsax.tag),
                          SizedBox(width: TSizes.spaceBtwItems / 2),

                          // 2.Status & date
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(
                                  '[#35453]',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          // 1.Icon
                          const Icon(Iconsax.calendar),
                          SizedBox(width: TSizes.spaceBtwItems / 2),

                          // 2.Status & date
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shipping Date',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(
                                  '14 NOV 2024',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
