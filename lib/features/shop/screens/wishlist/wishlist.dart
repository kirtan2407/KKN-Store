import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/common/widgets/icon/TCircular_Icon.dart';
import 'package:kkn_store/common/widgets/layout/grid_layout.dart';
import 'package:kkn_store/common/widgets/products.cart/products_card/product_vertical.dart';
import 'package:kkn_store/features/shop/controllers/wishlist_controller.dart';
import 'package:kkn_store/features/shop/screens/Home/home.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());
    final dark = THelperFunctions.isDarkMode(context);
    
    return Scaffold(
      appBar: KknAppbar( 
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            dark: dark,
            icon: Iconsax.add,
            onPressed: () => Get.to(() => const HomeScreen()), // Redirect to home to add more
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpacing),
          child: Column(
            children: [
              Obx(() {
                if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
                
                if (controller.wishlistProducts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        Text('Whoops! Wishlist is Empty...', style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: TSizes.defaultSpace),
                        Text('Select any one product like it', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  );
                }

                return TGridLayout(
                  itemCount: controller.wishlistProducts.length,
                  itemBuilder: (_, index) => TProductCardVertical(product: controller.wishlistProducts[index]),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
