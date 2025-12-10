import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/wishlist/wishlist_repository.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/utils/popups/loaders.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  final _repository = Get.put(WishlistRepository());
  final RxList<ProductModel> wishlistProducts = <ProductModel>[].obs;
  final RxSet<String> favorites = <String>{}.obs; // Store product IDs
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    try {
      isLoading.value = true;
      final products = await _repository.getWishlistProducts();
      wishlistProducts.assignAll(products);
      favorites.assignAll(products.map((e) => e.id));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleWishlist(ProductModel product) async {
    try {
      // Optimistic update
      if (favorites.contains(product.id)) {
        favorites.remove(product.id);
        wishlistProducts.removeWhere((p) => p.id == product.id);
        TLoaders.customToast(message: 'Removed from Wishlist');
      } else {
        favorites.add(product.id);
        wishlistProducts.add(product);
        TLoaders.customToast(message: 'Added to Wishlist');
      }
      
      // Call API
      await _repository.toggleWishlist(product.id);
      
    } catch (e) {
      // Revert on error (optional, but good practice)
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  bool isWishlisted(String productId) {
    return favorites.contains(productId);
  }
}
