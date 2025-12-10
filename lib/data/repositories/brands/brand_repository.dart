import 'package:get/get.dart';
import 'package:kkn_store/features/shop/models/brand_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _supabase = Supabase.instance.client;

  Future<List<BrandModel>> getAllBrands() async {
    try {
      final data = await _supabase.from('brands').select();
      return (data as List<dynamic>)
          .map((e) => BrandModel.fromJson(e))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching brands.';
    }
  }

  Future<List<BrandModel>> getFeaturedBrands() async {
    try {
      final data = await _supabase
          .from('brands')
          .select()
          .eq('is_featured', true)
          .limit(4);
      return (data as List<dynamic>)
          .map((e) => BrandModel.fromJson(e))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching featured brands.';
    }
  }
}
