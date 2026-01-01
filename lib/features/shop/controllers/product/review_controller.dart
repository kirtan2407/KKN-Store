import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/authentication/authentication_repository.dart';
import 'package:kkn_store/data/repositories/product/review_repository.dart';
import 'package:kkn_store/features/shop/models/review_model.dart';
import 'package:kkn_store/utils/popups/loaders.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

class ReviewController extends GetxController {
  static ReviewController get instance => Get.find();

  final _reviewRepository = Get.put(ReviewRepository());
  final rating = 0.0.obs;
  final review = TextEditingController();
  RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final isLoading = false.obs;

  // Stats
  final averageRating = 0.0.obs;
  final totalReviews = 0.obs;
  final starCounts = <int, double>{5: 0, 4: 0, 3: 0, 2: 0, 1: 0}.obs;
  
  // For Product Details Page
  final productPageReviewCount = 0.obs;

  Future<void> fetchProductReviewCount(String productId) async {
    productPageReviewCount.value = await _reviewRepository.getReviewCount(productId);
  }

  Future<void> fetchReviews(String productId) async {
    try {
      isLoading.value = true;
      final fetchedReviews = await _reviewRepository.fetchReviews(productId);
      reviews.assignAll(fetchedReviews);
      
      _calculateStats();

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _calculateStats() {
    if (reviews.isEmpty) {
      averageRating.value = 0.0;
      totalReviews.value = 0;
      starCounts.value = {5: 0.0, 4: 0.0, 3: 0.0, 2: 0.0, 1: 0.0};
      return;
    }

    double totalRating = 0.0;
    final counts = <int, double>{5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

    for (var r in reviews) {
      totalRating += r.rating;
      int star = r.rating.ceil();
      if (star < 1) star = 1;
      if (star > 5) star = 5;
      counts[star] = (counts[star] ?? 0) + 1;
    }

    averageRating.value = totalRating / reviews.length;
    totalReviews.value = reviews.length;
    
    // Normalize logic if needed, but for now just storing counts or ratios
    // For progress bar (0.0 to 1.0), we need ratio.
    final distribution = <int, double>{};
    counts.forEach((key, value) {
      distribution[key] = value / reviews.length;
    });
    starCounts.value = distribution;
  }

  Future<void> deleteReview(String reviewId, String productId) async {
    try {
      TLoaders.customToast(message: 'Deleting Review...');
      await _reviewRepository.deleteReview(reviewId);
      TLoaders.successSnackBar(title: 'Deleted', message: 'Review deleted successfully.');
      fetchReviews(productId);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> updateReview(ReviewModel review) async {
    try {
      TLoaders.customToast(message: 'Updating Review...');
      await _reviewRepository.updateReview(review);
      TLoaders.successSnackBar(title: 'Success', message: 'Review updated successfully.');
      fetchReviews(review.productId);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  void showEditReviewDialog(ReviewModel oldReview) {
    review.text = oldReview.comment ?? '';
    rating.value = oldReview.rating;

    Get.defaultDialog(
      title: 'Edit Review',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           Obx(() => RatingBar.builder(
            initialRating: rating.value,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (value) {
              rating.value = value;
            },
          )),
          const SizedBox(height: TSizes.spaceBtwItems),
          TextField(
            controller: review,
            decoration: const InputDecoration(
              hintText: 'Share your experience...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      confirm: Obx(() => ElevatedButton(
        onPressed: isLoading.value 
          ? null 
          : () {
              final newReview = ReviewModel(
                id: oldReview.id,
                userId: oldReview.userId,
                productId: oldReview.productId,
                rating: rating.value,
                comment: review.text.trim(),
                createdAt: oldReview.createdAt,
              );
              updateReview(newReview);
              Get.back();
            },
        child: const Text('Update'),
      )),
      cancel: TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
    );
  }

  Future<void> submitReview(String productId) async {
    try {
      if (rating.value == 0) {
        TLoaders.warningSnackBar(title: 'Rating Required', message: 'Please give a rating.');
        return;
      }

      isLoading.value = true;
      
      final userId = AuthenticationRepository.instance.authUser?.id;
      if (userId == null) {
        TLoaders.errorSnackBar(title: 'Error', message: 'User not logged in');
        return;
      }

      final newReview = ReviewModel(
        id: '', // Generated by DB
        userId: userId,
        productId: productId,
        rating: rating.value,
        comment: review.text.trim(),
        createdAt: DateTime.now(),
      );

      await _reviewRepository.addReview(newReview);
      
      // Refresh reviews
      await fetchReviews(productId);
      
      // Clear inputs and close dialog
      rating.value = 0;
      review.clear();
      Get.back();
      TLoaders.successSnackBar(title: 'Success', message: 'Review added successfully!');

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
