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

  Future<void> fetchAllProducts() async {
    try {
      // Prevent multiple simultaneous fetches
      if (isLoading.value) return;
      
      isLoading.value = true;
      final fetchedProducts = await repository.getAllProducts();
      assignProducts(fetchedProducts);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(String? query) async {
    try {
      if (query == null) return [];
      // Implement query fetching if needed
      return [];
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts(selectedSortOption.value);
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Newest':
        products.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      case 'Sale':
        products.sort((a, b) {
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
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }
}