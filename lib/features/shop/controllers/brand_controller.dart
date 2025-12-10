import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/brands/brand_repository.dart';
import 'package:kkn_store/data/repositories/products/product_repository.dart';
import 'package:kkn_store/features/shop/models/brand_model.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/utils/popups/loaders.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final _repository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;
      final brands = await _repository.getFeaturedBrands();
      featuredBrands.assignAll(brands);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllBrands() async {
    try {
      isLoading.value = true;
      final brands = await _repository.getAllBrands();
      allBrands.assignAll(brands);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get Brand Specific Products
  Future<List<ProductModel>> getBrandProducts(String brandId, int limit) async {
    try {
      final products = await ProductRepository.instance.fetchProductsByBrand(
        brandId,
        limit,
      );
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
