import 'package:get/get.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _supabase = Supabase.instance.client;

  /// Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      // Fetch products and join with brands
      // Note: Supabase join syntax depends on foreign keys. 
      // Assuming foreign keys are set up correctly in SQL:
      // products(..., brand:brands(*))
      
      final data = await _supabase
          .from('products')
          .select('*, brand:brands(*)')
          .eq('is_featured', true)
          .limit(4);
          
      return (data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get all products
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final data = await _supabase
          .from('products')
          .select('*, brand:brands(*)');
          
      return (data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get products by brand
  Future<List<ProductModel>> fetchProductsByBrand(String brandId, int limit) async {
    try {
      final query = _supabase
          .from('products')
          .select('*, brand:brands(*)')
          .eq('brand_id', brandId);
      
      if (limit > -1) {
        final data = await query.limit(limit);
        return (data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();
      } else {
        final data = await query;
        return (data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();
      }
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get products by category
  Future<List<ProductModel>> fetchProductsByCategory(String categoryId, int limit) async {
    try {
      final query = _supabase
          .from('products')
          .select('*, brand:brands(*)')
          .eq('category_id', categoryId);
      
      if (limit > -1) {
        final data = await query.limit(limit);
        return (data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();
      } else {
        final data = await query;
        return (data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();
      }
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
