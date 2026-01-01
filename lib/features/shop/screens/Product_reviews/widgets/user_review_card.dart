import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/products.cart/ratings/rating_bar_indicator.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:readmore/readmore.dart';
import 'package:kkn_store/features/shop/models/review_model.dart';
import 'package:kkn_store/data/repositories/authentication/authentication_repository.dart';
import 'package:kkn_store/features/shop/controllers/product/review_controller.dart';
import 'package:get/get.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key, required this.review});

  final ReviewModel review;

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
                 CircleAvatar(
                  backgroundImage: review.userImage != null 
                     ? NetworkImage(review.userImage!) 
                     : const AssetImage(TImages.userAvatar) as ImageProvider,
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(
                  review.userName ?? 'User',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            if (AuthenticationRepository.instance.authUser?.id == review.userId)
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) {
                if (value == 'delete') {
                  Get.put(ReviewController()).deleteReview(review.id, review.productId);
                } else if (value == 'edit') {
                  Get.put(ReviewController()).showEditReviewDialog(review);
                }
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Review
        Row(
          children: [
            TRatingBarIndicator(rating: review.rating),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(review.createdAt.toString().split(' ')[0], style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: TSizes.spaceBtwItems),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        ReadMoreText(
          review.comment ?? '',
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

        // Removed Company Review Dummy Data for simplicity or make it dynamic later
        const SizedBox(height: TSizes.spaceBtwsections),
      ],
    );
  }
}
