import 'package:get/get.dart';
import 'package:kkn_store/features/shop/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _supabase = Supabase.instance.client;

  /// Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final data = await _supabase.from('categories').select().order('name');
      return (data as List<dynamic>).map((e) => CategoryModel.fromJson(e)).toList();
    } catch (e) {
      print('DEBUG: Error fetching categories: $e'); // LOG THE ERROR
      throw 'Something went wrong fetching categories: $e';
    }
  }

  /// Get sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final data = await _supabase
          .from('categories')
          .select()
          .eq('parent_id', categoryId)
          .order('name');
      return (data as List<dynamic>).map((e) => CategoryModel.fromJson(e)).toList();
    } catch (e) {
      print('DEBUG: Error fetching sub-categories: $e');
      throw 'Something went wrong fetching sub-categories';
    }
  }
}
