import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/banners/banner_repository.dart';
import 'package:kkn_store/features/shop/models/banner_model.dart';
import 'package:kkn_store/utils/popups/loaders.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final _repository = Get.put(BannerRepository());

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      final fetchedBanners = await _repository.fetchBanners();
      banners.assignAll(fetchedBanners);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
