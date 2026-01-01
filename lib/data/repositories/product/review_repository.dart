import 'package:get/get.dart';
import 'package:kkn_store/features/shop/models/review_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewRepository extends GetxController {
  static ReviewRepository get instance => Get.find();

  final _supabase = Supabase.instance.client;

  /// Update a review
  Future<void> updateReview(ReviewModel review) async {
    try {
      await _supabase.from('reviews').update({
        'rating': review.rating,
        'comment': review.comment,
      }).eq('id', review.id);
    } catch (e) {
      throw 'Something went wrong updating review: $e';
    }
  }

  /// Delete a review
  Future<void> deleteReview(String reviewId) async {
    try {
      await _supabase.from('reviews').delete().eq('id', reviewId);
    } catch (e) {
      throw 'Something went wrong deleting review: $e';
    }
  }

  /// Get review count for a product
  Future<int> getReviewCount(String productId) async {
    try {
      final response = await _supabase
          .from('reviews')
          .count()
          .eq('product_id', productId);
      return response;
    } catch (e) {
      return 0; // Return 0 on error
    }
  }

  /// Initial fetch (existing)
  Future<List<ReviewModel>> fetchReviews(String productId) async {
    try {
      final response = await _supabase
          .from('reviews')
          .select('*, profiles(full_name, avatar_url)')
          .eq('product_id', productId)
          .order('created_at', ascending: false);
      
      return (response as List<dynamic>).map((e) => ReviewModel.fromJson(e)).toList();
    } catch (e) {
      throw 'Something went wrong fetching reviews: $e';
    }
  }

  /// Add a new review
  Future<void> addReview(ReviewModel review) async {
    try {
      await _supabase.from('reviews').insert(review.toJson());
    } catch (e) {
      throw 'Something went wrong adding review: $e';
    }
  }
}
