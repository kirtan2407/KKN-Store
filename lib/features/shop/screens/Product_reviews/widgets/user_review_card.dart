import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/products.cart/ratings/rating_bar_indicator.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(TImages.userAvatar),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(
                  'Nethan Brown',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Review
        Row(
          children: [
            TRatingBarIndicator(rating: 4),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('01 Nov, 2024', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: TSizes.spaceBtwItems),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        ReadMoreText(
          "Good for my multiple sclerosis body : First disability shoes I’ve ever bought & I LOVE them. Although I should’ve went up half a size for my compression socks, I have nothing bad to say about them at all! BEST work shoe for hospital workers that are around sick patients!",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less',
          trimCollapsedText: ' show more',
          moreStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: TColors.primaryColor,
          ),
          lessStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: TColors.primaryColor,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Company Review
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ClickBuy's Store",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '02 Nov, 2024',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                ReadMoreText(
                  "Good for my multiple sclerosis body : First disability shoes I’ve ever bought & I LOVE them. Although I should’ve went up half a size for my compression socks, I have nothing bad to say about them at all! BEST work shoe for hospital workers that are around sick patients!",
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' show less',
                  trimCollapsedText: ' show more',
                  moreStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: TColors.primaryColor,
                  ),
                  lessStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: TColors.primaryColor,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwsections),
      ],
    );
  }
}
