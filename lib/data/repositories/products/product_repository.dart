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


  /// Get distinct Brand IDs for selected Categories
  Future<List<String>> getBrandIdsForCategories(List<String> categoryIds) async {
    try {
      final data = await _supabase
          .from('products')
          .select('brand_id')
          .filter('category_id', 'in', categoryIds);
      
      // Extract unique IDs
      final List<String> brandIds = (data as List<dynamic>)
          .map((e) => e['brand_id'] as String?)
          .where((id) => id != null && id.isNotEmpty)
          .cast<String>()
          .toSet()
          .toList();
          
      return brandIds;
    } catch (e) {
      throw 'Something went wrong fetching brands for filter: $e';
    }
  }
  /// Search products with pagination and filters
  Future<List<ProductModel>> searchProducts({
    required String query,
    required int limit,
    required int offset,
    List<String>? categoryIds,
    List<String>? brandIds,
    double? minPrice,
    double? maxPrice,
    double? minSalePercentage,
    double? maxSalePercentage,
    double? minRating,
  }) async {
    try {
      var queryBuilder = _supabase.from('products').select('*, brand:brands(*)');

      // 1. Text Search (Case-insensitive)
      if (query.isNotEmpty) {
        queryBuilder = queryBuilder.ilike('title', '%$query%');
      }

      // 2. Category Filter (Multi-Select)
      if (categoryIds != null && categoryIds.isNotEmpty) {
        queryBuilder = queryBuilder.filter('category_id', 'in', categoryIds);
      }

      // 3. Brand Filter (Multi-Select)
      if (brandIds != null && brandIds.isNotEmpty) {
        queryBuilder = queryBuilder.filter('brand_id', 'in', brandIds);
      }

      // 4. Sale Percentage Range
      if (minSalePercentage != null) {
        queryBuilder = queryBuilder.gte('sale_percentage', minSalePercentage);
      }
       if (maxSalePercentage != null) {
        queryBuilder = queryBuilder.lte('sale_percentage', maxSalePercentage);
      }

      // 5. Rating Filter
      if (minRating != null) {
        queryBuilder = queryBuilder.gte('average_rating', minRating);
      }

      // 6. Pagination
      final data = await queryBuilder.range(offset, offset + limit - 1);

      return (data as List<dynamic>).map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw 'Error searching products: $e';
    }
  }
}
