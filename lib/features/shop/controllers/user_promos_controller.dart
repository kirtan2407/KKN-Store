import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/promo/promo_repository.dart';
import 'package:kkn_store/features/shop/models/promo_model.dart';

class UserPromosController extends GetxController {
  final promoRepo = Get.put(PromoRepository());
  RxList<PromoModel> activePromos = <PromoModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPromos();
  }

  Future<void> fetchPromos() async {
    try {
      isLoading.value = true;
      final promos = await promoRepo.fetchAllActivePromos();
      activePromos.assignAll(promos);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
