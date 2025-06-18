import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/brands/brand_show_case.dart';
import 'package:kkn_store/common/widgets/layout/grid_layout.dart';
import 'package:kkn_store/common/widgets/products.cart/products_card/product_vertical.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(TSizes.defaultSpacing),
          child: Column(
            children: [
              /// ---brands---
              TBrandShowCase(
                dark: dark,
                images: [TImages.nikeshoes, TImages.nikejacket, TImages.nikem],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// ---haedings---
              TSectionHeading(title: 'You might like', onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// ---
              TGridLayout(
                itemCount: 6,
                itemBuilder: (_, index) => TProductCardVertical(),
              ),
              SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ],
    );
  }
}
