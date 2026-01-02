import 'package:get/get.dart';
import 'package:kkn_store/features/shop/models/banner_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _supabase = Supabase.instance.client;

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final data = await _supabase
          .from('banners')
          .select()
          .eq('active', true);

      return (data as List<dynamic>)
          .map((e) => BannerModel.fromJson(e))
          .toList();
    } catch (e) {
      print('DEBUG: Error fetching banners: $e'); // LOG THE ERROR
      throw 'Something went wrong while fetching banners: $e';
    }
  }
}
