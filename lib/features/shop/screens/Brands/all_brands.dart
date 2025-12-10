// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kkn_store/common/widgets/appbar/appbar.dart';
// import 'package:kkn_store/common/widgets/layout/grid_layout.dart';
// import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
// import 'package:kkn_store/features/shop/screens/Brands/brand_products.dart';
// import 'package:kkn_store/features/shop/screens/Store/widgets/TCard.dart';
// import 'package:kkn_store/utils/constants/sizes.dart';
// import 'package:kkn_store/utils/helpers/helper_function.dart';

// import 'package:kkn_store/features/shop/controllers/brand_controller.dart';

// class AllBrands extends StatelessWidget {
//   const AllBrands({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     final controller = Get.put(BrandController());

//     return Scaffold(
//       appBar: const KknAppbar(title: Text('Brands'), showArrowBack: true),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Column(
//             children: [
//               const TSectionHeading(title: 'Brands', showActionButton: false),
//               const SizedBox(height: TSizes.spaceBtwItems),

//               // Brands
//               Obx(() {
//                 if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());

//                 if (controller.allBrands.isEmpty) {
//                   controller.getAllBrands(); // Fetch if empty
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 return TGridLayout(
//                   itemCount: controller.allBrands.length,
//                   mainAxisExtent: 80,
//                   itemBuilder:
//                       (context, index) {
//                         final brand = controller.allBrands[index];
//                         return TBrandCard(
//                           dark: dark,
//                           showBorder: true,
//                           brand: brand,
//                           onTap: () => Get.to(() => BrandProducts(brand: brand)),
//                         );
//                       },
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/layout/grid_layout.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/features/shop/screens/Brands/brand_products.dart';
import 'package:kkn_store/features/shop/screens/Store/widgets/TCard.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

import 'package:kkn_store/features/shop/controllers/brand_controller.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(BrandController());

    return Scaffold(
      appBar: const KknAppbar(title: Text('Brands'), showArrowBack: true),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            const TSectionHeading(title: 'Brands', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.allBrands.isEmpty) {
                  return const Center(child: Text('No Brands Found'));
                }

                return TGridLayout(
                  itemCount: controller.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) {
                    final brand = controller.allBrands[index];
                    return TBrandCard(
                      dark: dark,
                      showBorder: true,
                      brand: brand,
                      onTap: () => Get.to(() => BrandProducts(brand: brand)),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
