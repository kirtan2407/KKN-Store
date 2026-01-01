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
  
  // Filter & Search
  final RxString searchQuery = ''.obs;
  final RxList<String> selectedCategoryIds = <String>[].obs;
  final RxSet<String> brandIdsFromCategories = <String>{}.obs; // Brands available in selected categories

  List<BrandModel> get filteredBrands {
    return allBrands.where((brand) {
      final matchesSearch = brand.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      
      // If no categories selected, match only search
      if (selectedCategoryIds.isEmpty) return matchesSearch;

      // If categories selected, brand must be in the fetched list
      final matchesCategory = brandIdsFromCategories.contains(brand.id);
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

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

  /// Get Brand IDs that have products in selected categories
  Future<void> fetchBrandIdsForSelectedCategories() async {
    if (selectedCategoryIds.isEmpty) {
      brandIdsFromCategories.clear();
      return;
    }

    try {
      isLoading.value = true;
       // We need to query products table directly here or use repository
       // Providing a direct supabase query here for efficiency as generic repo might not support distinct brand fetch
       // Assuming Supabase client is available or we use ProductRepository
       final uniqueBrandIds = await ProductRepository.instance.getBrandIdsForCategories(selectedCategoryIds);
       brandIdsFromCategories.assignAll(uniqueBrandIds);

    } catch (e) {
       TLoaders.errorSnackBar(title: 'Error', message: 'Could not filter brands: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
