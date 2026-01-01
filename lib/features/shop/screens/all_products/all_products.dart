// import 'package:flutter/material.dart';
// import 'package:kkn_store/common/widgets/appbar/appbar.dart';
// import 'package:get/get.dart';
// import 'package:kkn_store/common/widgets/products.cart/sorttable/sortable_products.dart';
// import 'package:kkn_store/features/shop/controllers/all_products_controller.dart';
// import 'package:kkn_store/utils/constants/sizes.dart';

// class AllProducts extends StatefulWidget {
//   const AllProducts({super.key});

//   @override
//   State<AllProducts> createState() => _AllProductsState();
// }

// class _AllProductsState extends State<AllProducts> {
//   final controller = Get.put(AllProductsController());

//   @override
//   void initState() {
//     super.initState();
//     // Fetch products when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (controller.products.isEmpty) {
//         controller.fetchAllProducts();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: const KknAppbar(
//         title: Text('Popular Products'),
//         showArrowBack: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Obx(() {
//             if (controller.isLoading.value) {
//               return const Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 100),
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             }
//             if (controller.products.isEmpty) {
//               return const Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 100),
//                   child: Text('No Products Found'),
//                 ),
//               );
//             }
//             return TSortableProducts(products: controller.products);
//           }),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/products.cart/sorttable/sortable_products.dart';
import 'package:kkn_store/features/shop/controllers/all_products_controller.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  void initState() {
    super.initState();
    // Initialize controller and fetch products
    final controller = Get.put(AllProductsController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AllProductsController>();

    return Scaffold(
      appBar: const KknAppbar(
        title: Text('Popular Products'),
        showArrowBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (controller.products.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text('No Products Found'),
                ),
              );
            }
            return const TSortableProducts();
          }),
        ),
      ),
    );
  }
}