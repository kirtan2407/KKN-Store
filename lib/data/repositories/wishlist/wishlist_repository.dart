import 'package:get/get.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WishlistRepository extends GetxController {
  static WishlistRepository get instance => Get.find();

  final _supabase = Supabase.instance.client;

  Future<List<ProductModel>> getWishlistProducts() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return [];

      // Assuming a 'wishlist' table exists with 'product_id' and 'user_id'
      // and we join with 'products'
      final data = await _supabase
          .from('wishlist')
          .select('product_id, products:product_id(*, brand:brands(*))')
          .eq('user_id', userId);

      return (data as List<dynamic>)
          .map((e) => ProductModel.fromJson(e['products']))
          .toList();
    } catch (e) {
      // If table doesn't exist or other error, return empty for now
      return [];
    }
  }

  Future<void> toggleWishlist(String productId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      // Check if exists
      final exists = await _supabase
          .from('wishlist')
          .select()
          .eq('user_id', userId)
          .eq('product_id', productId)
          .maybeSingle();

      if (exists != null) {
        // Remove
        await _supabase
            .from('wishlist')
            .delete()
            .eq('user_id', userId)
            .eq('product_id', productId);
      } else {
        // Add
        await _supabase.from('wishlist').insert({
          'user_id': userId,
          'product_id': productId,
        });
      }
    } catch (e) {
      throw 'Failed to toggle wishlist: $e';
    }
  }
}
