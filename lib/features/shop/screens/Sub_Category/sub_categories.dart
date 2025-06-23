import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/products.cart/products_card/product_horizontal.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KknAppbar(title: Text('Sports'), showArrowBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //Banner
            const TRoundedImage(
              imageUrl: TImages.poster1,
              width: double.infinity,
              applyImageRadius: true,
            ),
            const SizedBox(height: TSizes.spaceBtwsections),

            //Sub-categories - 1
            Column(
              children: [
                //heading
                TSectionHeading(title: 'Sports shoes', onPressed: () {}),
                const SizedBox(height: TSizes.spaceBtwItems / 2),

                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder:
                        (context, index) =>
                            SizedBox(width: TSizes.spaceBtwItems),
                    itemBuilder:
                        (context, index) => const TProductCardHorizontal(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwsections),

            //Sub-categories - 2
            Column(
              children: [
                //heading
                TSectionHeading(title: 'Sports Equipment', onPressed: () {}),
                const SizedBox(height: TSizes.spaceBtwItems / 2),

                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder:
                        (context, index) =>
                            SizedBox(width: TSizes.spaceBtwItems),
                    itemBuilder:
                        (context, index) => const TProductCardHorizontal(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwsections),

            //Sub-categories - 3
            Column(
              children: [
                //heading
                TSectionHeading(title: 'Track Suits', onPressed: () {}),
                const SizedBox(height: TSizes.spaceBtwItems / 2),

                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder:
                        (context, index) =>
                            SizedBox(width: TSizes.spaceBtwItems),
                    itemBuilder:
                        (context, index) => const TProductCardHorizontal(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwsections),
          ],
        ),
      ),
    );
  }
}
