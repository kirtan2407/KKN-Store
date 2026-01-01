import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kkn_store/features/shop/models/promo_model.dart';
import 'package:kkn_store/utils/popups/loaders.dart';

class PromoRepository extends GetxController {
  static PromoRepository get instance => Get.find();

  final _supabase = Supabase.instance.client;

  Future<PromoModel?> fetchPromo(String code) async {
    try {
      final response = await _supabase
          .from('promos')
          .select()
          .eq('code', code)
          .eq('is_active', true)
          .maybeSingle();

      if (response == null) {
        return null;
      }

      return PromoModel.fromJson(response);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to apply promo: $e');
      return null;
    }
  }

  Future<List<PromoModel>> fetchAllActivePromos() async {
    try {
      final response = await _supabase
          .from('promos')
          .select()
          .eq('is_active', true)
          .order('expiry_date', ascending: true);
          
      return (response as List<dynamic>).map((e) => PromoModel.fromJson(e)).toList();
    } catch (e) {
      throw 'Error fetching promos: $e';
    }
  }
}
