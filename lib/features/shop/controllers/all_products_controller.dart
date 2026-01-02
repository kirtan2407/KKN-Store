// import 'package:get/get.dart';
// import 'package:kkn_store/data/repositories/products/product_repository.dart';
// import 'package:kkn_store/features/shop/models/product_model.dart';
// import 'package:kkn_store/utils/popups/loaders.dart';

// class AllProductsController extends GetxController {
//   static AllProductsController get instance => Get.find();

//   final repository = ProductRepository.instance;
//   final RxString selectedSortOption = 'Name'.obs;
//   final RxList<ProductModel> products = <ProductModel>[].obs;
//   final RxBool isLoading = false.obs;

//   @override
//   void onInit() {
//     fetchAllProducts();
//     super.onInit();
//   }

//   Future<void> fetchAllProducts() async {
//     try {
//       isLoading.value = true;
//       final fetchedProducts = await repository.getAllProducts();
//       assignProducts(fetchedProducts);
//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<List<ProductModel>> fetchProductsByQuery(String? query) async {
//     try {
//       if (query == null) return [];
//       // Implement query fetching if needed
//       return [];
//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//       return [];
//     }
//   }

//   void assignProducts(List<ProductModel> products) {
//     this.products.assignAll(products);
//     sortProducts('Name');
//   }

//   void sortProducts(String sortOption) {
//     selectedSortOption.value = sortOption;

//     switch (sortOption) {
//       case 'Name':
//         products.sort((a, b) => a.title.compareTo(b.title));
//         break;
//       case 'Higher Price':
//         products.sort((a, b) => b.price.compareTo(a.price));
//         break;
//       case 'Lower Price':
//         products.sort((a, b) => a.price.compareTo(b.price));
//         break;
//       case 'Newest':
//         products.sort((a, b) => a.date!.compareTo(b.date!));
//         break;
//       case 'Sale':
//         products.sort((a, b) {
//           if (b.salePrice > 0) {
//             return b.salePrice.compareTo(a.salePrice);
//           } else if (a.salePrice > 0) {
//             return -1;
//           } else {
//             return 1;
//           }
//         });
//         break;
//       default:
//         products.sort((a, b) => a.title.compareTo(b.title));
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:kkn_store/data/repositories/products/product_repository.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/utils/popups/loaders.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxList<ProductModel> searchResults = <ProductModel>[].obs;
  
  // Search State
  final RxString searchQuery = ''.obs;
  // Use Lists for Multi-Select
  final RxList<String> searchCategoryIds = <String>[].obs;
  final RxList<String> searchBrandIds = <String>[].obs;
  
  // Advanced Filters
  final RxDouble minSalePercentage = (-1.0).obs; // -1 means No Filter
  final RxDouble maxSalePercentage = (-1.0).obs;
  final RxDouble minRating = (-1.0).obs; // -1 means No Filter
  
  // Pagination State
  final RxInt currentPage = 0.obs;
  final int pageSize = 10;
  final RxBool isLastPage = false.obs;
  final RxBool isSearchLoading = false.obs; // Specific loader for search

  @override
  void onInit() {
    super.onInit();
    // Debounce search input: wait 500ms after user stops typing
    debounce(searchQuery, (_) => fetchSearchResults(reset: true), time: const Duration(milliseconds: 500));
  }

  Future<void> fetchAllProducts() async {
    try {
      if (isLoading.value) return;
      isLoading.value = true;
      final fetchedProducts = await repository.getAllProducts();
      products.assignAll(fetchedProducts);
      sortProducts(selectedSortOption.value);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Initial Fetch (Popular Products) - Keep existing logic or separate? 
  // For "All Products" screen, we just treat it as an empty query search if needed, but keeping separate for now to avoid breaking "Popular" flow if it's special.
  // Actually, let's keep fetchAllProducts for the initial "Popular" list when no search is active.
  
  // Search Action (Called by UI input)
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Context Filters (Called when entering search from specific page)
  void setContext({String? categoryId, String? brandId}) {
    searchCategoryIds.clear();
    searchBrandIds.clear();
    if (categoryId != null && categoryId.isNotEmpty) {
      searchCategoryIds.add(categoryId);
    }
    if (brandId != null && brandId.isNotEmpty) {
      searchBrandIds.add(brandId);
    }
    // Optional: trigger immediate fetch if context is set? 
    // Usually user types first, so we wait. Or if it's "Show all in this category", we might trigger.
  }

  Future<void> fetchSearchResults({bool reset = false}) async {
    try {
      if (reset) {
        currentPage.value = 0;
        searchResults.clear();
        isLastPage.value = false;
      }

      if (isLastPage.value) return;

      isSearchLoading.value = true;

      final offset = currentPage.value * pageSize;
      
      final newProducts = await repository.searchProducts(
        query: searchQuery.value, 
        limit: pageSize, 
        offset: offset,
        categoryIds: searchCategoryIds.isNotEmpty ? searchCategoryIds : null,
        brandIds: searchBrandIds.isNotEmpty ? searchBrandIds : null,
        minSalePercentage: minSalePercentage.value != -1 ? minSalePercentage.value : null,
        maxSalePercentage: maxSalePercentage.value != -1 ? maxSalePercentage.value : null,
        minRating: minRating.value != -1 ? minRating.value : null,
      );

      if (newProducts.length < pageSize) {
        isLastPage.value = true;
      }

      if (reset) {
        searchResults.assignAll(newProducts);
      } else {
        searchResults.addAll(newProducts);
      }
      
      currentPage.value++;
      
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Search Error', message: e.toString());
    } finally {
      isSearchLoading.value = false;
    }
  }

  void loadMore() {
    if (!isSearchLoading.value && !isLastPage.value) {
      fetchSearchResults(reset: false);
    }
  }

  // --- Sorting (Applied to Search Results client-side or server-side?) ---
  // Ideally server-side, but maintaining client-sort for current batch is cheaper for now if requirements allow.
  // Requirement says "Server-side search". Sorting usually goes with it.
  // For now, let's sort the loaded list client-side to keep it simple, or re-fetch.
  // Given "All Products" existing sort logic, let's apply it to searchResults too.
  // --- Filter Removal Methods ---
  void removeCategoryFilter(String categoryId) {
    searchCategoryIds.remove(categoryId);
    fetchSearchResults(reset: true);
  }

  void removeBrandFilter(String brandId) {
    searchBrandIds.remove(brandId);
    fetchSearchResults(reset: true);
  }

  void removeSaleFilter() {
    minSalePercentage.value = -1.0;
    fetchSearchResults(reset: true);
  }

  void removeRatingFilter() {
    minRating.value = -1.0;
    fetchSearchResults(reset: true);
  }

  void sortSearchResults(String sortOption) {
    selectedSortOption.value = sortOption;
    _applySort(searchResults, sortOption);
  }

  // Original methods (modified to separate concerns or reused)
  // ... keeping fetchAllProducts for "Popular" list to allow standalone display ...

  // ... keeping fetchAllProducts for "Popular" list to allow standalone display ...

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts(selectedSortOption.value);
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;
    _applySort(products, sortOption);
  }

  void _applySort(RxList<ProductModel> list, String sortOption) {
     switch (sortOption) {
      case 'Name':
        list.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Newest':
        list.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      case 'Sale':
         list.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      default:
        list.sort((a, b) => a.title.compareTo(b.title));
    }
  }
}