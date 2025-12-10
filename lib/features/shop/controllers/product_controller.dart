import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/products/product_repository.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/utils/popups/loaders.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final _productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;

      // Fetch Products
      final products = await _productRepository.getFeaturedProducts();

      // Assign Products
      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchProductsByCategory(String categoryId, {int limit = -1}) async {
    try {
      return await _productRepository.fetchProductsByCategory(categoryId, limit);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
