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
      throw 'Something went wrong. Please try again';
    }
  }
}
