// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/features/shop/screens/Product_reviews/widgets/all_over_rating.dart';
import 'package:kkn_store/common/widgets/products.cart/ratings/rating_bar_indicator.dart';
import 'package:kkn_store/features/shop/screens/Product_reviews/widgets/user_review_card.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/device/device_utility.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appbar
      appBar: KknAppbar(
        title: Text('Reviews & Ratings', style: TextStyle(fontSize: TSizes.lg)),
        showArrowBack: true,
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ratings and reviews are verified and are from people who use the same type of device that you use.",
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Overall Product Ratings
              const TAllOverRatingIndicator(),
              TRatingBarIndicator(rating: 4.5),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  '(11909)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwsections),

              /// User Reviews list
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
