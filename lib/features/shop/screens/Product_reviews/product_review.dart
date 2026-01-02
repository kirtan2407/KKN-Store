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
import 'package:get/get.dart';
import 'package:kkn_store/features/shop/controllers/product/review_controller.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewController());
    controller.fetchReviews(productId);

    return Scaffold(
      /// appbar
      appBar: KknAppbar(
        title: Text('Reviews & Ratings', style: TextStyle(fontSize: TSizes.lg)),
        showArrowBack: true,
      ),

      /// Floating Action Button to Add Review
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primaryColor,
        child: const Icon(Iconsax.add, color: Colors.white),
        onPressed: () => _showAddReviewDialog(context, controller),
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
              Obx(
                () => TRatingBarIndicator(
                  rating: controller.averageRating.value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Obx(
                  () => Text(
                    '(${controller.totalReviews.value})',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwsections),

              /// User Reviews list
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.reviews.isEmpty) {
                  return const Center(child: Text('No reviews yet. Be the first to review!'));
                }
                
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.reviews.length,
                    itemBuilder: (_, index) {
                       return UserReviewCard(review: controller.reviews[index]);
                    }
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddReviewDialog(BuildContext context, ReviewController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Write a Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                controller.rating.value = rating;
              },
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            TextField(
              controller: controller.review,
              decoration: const InputDecoration(
                hintText: 'Share your experience...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          Obx(() => ElevatedButton(
            onPressed: controller.isLoading.value 
                ? null 
                : () => controller.submitReview(productId),
            child: controller.isLoading.value 
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white)) 
                : const Text('Submit'),
          )),
        ],
      ),
    );
  }
}
