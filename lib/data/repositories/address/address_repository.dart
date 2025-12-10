import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/authentication/authentication_repository.dart';
import 'package:kkn_store/features/personalization/models/address_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _supabase = Supabase.instance.client;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.id;
      if (userId == null) throw 'Unable to find user information';

      final result = await _supabase.from('addresses').select().eq('user_id', userId);
      return (result as List<dynamic>).map((e) => AddressModel.fromJson(e)).toList();
    } catch (e) {
      throw 'Something went wrong while fetching addresses. Please try again later.';
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.id;
      if (userId == null) throw 'Unable to find user information';

      await _supabase.from('addresses').update({'is_selected': selected}).eq('id', addressId).eq('user_id', userId);
    } catch (e) {
      throw 'Unable to update your address selection. Try again later.';
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.id;
      if (userId == null) throw 'Unable to find user information';

      final currentAddress = await _supabase.from('addresses').insert({
        ...address.toJson(),
        'user_id': userId,
        'is_selected': true, // New address is selected by default
      }).select();
      
      return currentAddress.first['id'];
    } catch (e) {
      throw 'Something went wrong while saving Address. Try again later.';
    }
  }
}
