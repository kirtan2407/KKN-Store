// // ignore_for_file: duplicate_import

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:kkn_store/common/style/shadows.dart';
// import 'package:kkn_store/common/widgets/icon/TCircular_Icon.dart';
// import 'package:kkn_store/common/widgets/text/TBrand_title_Text_with_verify_Icon.dart';
// import 'package:kkn_store/common/widgets/text/product_price_text.dart';
// import 'package:kkn_store/common/widgets/text/product_title.dart';
// import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
// import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
// import 'package:kkn_store/features/shop/screens/Product_details/product_details.dart';
// import 'package:kkn_store/utils/constants/colors.dart';
// import 'package:kkn_store/utils/constants/image_strings.dart';
// import 'package:kkn_store/utils/constants/sizes.dart';
// import 'package:kkn_store/utils/helpers/helper_function.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:kkn_store/common/style/shadows.dart';
// import 'package:kkn_store/common/widgets/icon/TCircular_Icon.dart';
// import 'package:kkn_store/common/widgets/text/TBrand_title_Text_with_verify_Icon.dart';
// import 'package:kkn_store/common/widgets/text/product_price_text.dart';
// import 'package:kkn_store/common/widgets/text/product_title.dart';
// import 'package:kkn_store/features/shop/models/product_model.dart';
// import 'package:kkn_store/features/shop/controllers/wishlist_controller.dart';
// import 'package:kkn_store/features/shop/controllers/cart_controller.dart';
// import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
// import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
// import 'package:kkn_store/features/shop/screens/Product_details/product_details.dart';
// import 'package:kkn_store/utils/constants/colors.dart';
// import 'package:kkn_store/utils/constants/sizes.dart';
// import 'package:kkn_store/utils/helpers/helper_function.dart';

// class TProductCardVertical extends StatelessWidget {
//   const TProductCardVertical({super.key, required this.product});

//   final ProductModel product;

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);

//     /// container with side paddings , colors , edgs , radius and shadow.
//     return GestureDetector(
//       onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
//       child: Container(
//         width: 180,
//         padding: const EdgeInsets.all(1),
//         decoration: BoxDecoration(
//           boxShadow: [TShadowStyle.verticalProductShadow],
//           borderRadius: BorderRadius.circular(TSizes.productImageRadius),
//           color: dark ? TColors.darkerGrey : TColors.white,
//         ),
//         child: Column(
//           children: [
//             /// Thambnail , wishlist Button , Discount Tag
//             TRoundedContainer(
//               height: 180,
//               padding: const EdgeInsets.all(TSizes.sm),
//               backgroundColor: dark ? TColors.dark : TColors.light,
//               child: Stack(
//                 children: [
//                   /// --- Thambnail Image ---
//                   TRoundedImage(
//                     imageUrl: product.thumbnail,
//                     applyImageRadius: true,
//                     isNetworkImage: true,
//                   ),

//                   /// --- Seal Tag ---
//                   if (product.salePrice > 0)
//                     Positioned(
//                       top: 12,
//                       left: 12,
//                       child: TRoundedContainer(
//                         radius: TSizes.sm,
//                         backgroundColor: TColors.secondary.withOpacity(0.8),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: TSizes.sm,
//                           vertical: TSizes.xs,
//                         ),
//                         child: Text(
//                           '${((product.price - product.salePrice) / product.price * 100).round()}%',
//                           style: Theme.of(
//                             context,
//                           ).textTheme.labelLarge!.copyWith(color: TColors.black),
//                         ),
//                       ),
//                     ),

//                   /// --- Favourite Icon Button ---
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: Obx(() {
//                       final controller = Get.put(WishlistController());
//                       final isWishlisted = controller.isWishlisted(product.id);
//                       return TCircularIcon(
//                         icon: isWishlisted ? Iconsax.heart5 : Iconsax.heart,
//                         color: isWishlisted ? Colors.red : TColors.darkGrey,
//                         onPressed: () => controller.toggleWishlist(product),
//                         dark: dark,
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: TSizes.spaceBtwItems / 2),

//             /// --- Details ---
//             Padding(
//               padding: const EdgeInsets.only(left: TSizes.sm),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TProductsTitleText(
//                     title: product.title,
//                     smallSize: true,
//                   ),
//                   const SizedBox(height: TSizes.spaceBtwItems / 2),

//                   /// Brand name
//                   TBrandTitleWithVerifiedIcon(title: product.brand?.name ?? ''),
//                 ],
//               ),
//             ),
//             // Todo : Add Spacer() here to keep the height of each box same in case 1 or 2 lines Headings
//             const Spacer(),

//             ///price Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 /// Price
//                 Padding(
//                   padding: const EdgeInsets.only(left: TSizes.sm),
//                   child: TProductPriceText(price: product.price.toString()),
//                 ),

//                 /// Add to cart button
//                 /// Add to cart button
//                 Obx(() {
//                   final cartController = Get.put(CartController());
//                   final productQuantityInCart = cartController.getProductQuantityInCart(product.id);
//                   return InkWell(
//                     onTap: () {
//                       final cartItem = cartController.convertProductToCartItem(product, 1);
//                       cartController.addOneToCart(cartItem);
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: productQuantityInCart > 0 ? TColors.primaryColor : TColors.dark,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(TSizes.cardRadiusMd),
//                           bottomRight: Radius.circular(TSizes.productImageRadius),
//                         ),
//                       ),
//                       child: SizedBox(
//                         width: TSizes.iconLg * 1.2,
//                         height: TSizes.iconLg * 1.2,
//                         child: Center(
//                           child: Icon(
//                             productQuantityInCart > 0 ? Iconsax.shopping_cart5 : Iconsax.add,
//                             color: TColors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: duplicate_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:kkn_store/common/style/shadows.dart';
import 'package:kkn_store/common/widgets/icon/TCircular_Icon.dart';
import 'package:kkn_store/common/widgets/text/TBrand_title_Text_with_verify_Icon.dart';
import 'package:kkn_store/common/widgets/text/product_price_text.dart';
import 'package:kkn_store/common/widgets/text/product_title.dart';

import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/features/shop/controllers/wishlist_controller.dart';
import 'package:kkn_store/features/shop/controllers/cart_controller.dart';

import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/features/shop/screens/Product_details/product_details.dart';

import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            /// Thumbnail Section
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  /// Product image
                  TRoundedImage(
                    imageUrl: product.thumbnail,
                    applyImageRadius: true,
                    isNetworkImage: true,
                  ),

                  /// Discount Tag
                  if (product.salePrice > 0)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm,
                          vertical: TSizes.xs,
                        ),
                        child: Text(
                          '${((product.price - product.salePrice) / product.price * 100).round()}%',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: TColors.black),
                        ),
                      ),
                    ),

                  /// Wishlist Icon
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Obx(() {
                      final controller = Get.put(WishlistController());
                      final isWishlisted = controller.isWishlisted(product.id);
                      return TCircularIcon(
                        icon: isWishlisted ? Iconsax.heart5 : Iconsax.heart,
                        color: isWishlisted ? Colors.red : TColors.darkGrey,
                        onPressed: () => controller.toggleWishlist(product),
                        dark: dark,
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems / 2),

            /// Product Title & Brand
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductsTitleText(title: product.title, smallSize: true),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  TBrandTitleWithVerifiedIcon(title: product.brand?.name ?? ''),
                ],
              ),
            ),

            const Spacer(),

            /// Price + Cart Button Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Product Price
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(price: product.price.toString()),
                ),

                /// Add to Cart Button (with one-time logic)
                Obx(() {
                  final cartController = Get.put(CartController());
                  final productQuantityInCart = cartController
                      .getProductQuantityInCart(product.id);

                  return InkWell(
                    onTap: () {
                      if (productQuantityInCart > 0) {
                        THelperFunctions.showToast(
                          message: "Already added to cart! Check your cart.",
                        );
                      } else {
                        final cartItem = cartController
                            .convertProductToCartItem(product, 1);
                        cartController.addOneToCart(cartItem);

                        THelperFunctions.showToast(message: "Added to cart");
                      }
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            productQuantityInCart > 0
                                ? TColors.primaryColor
                                : TColors.dark,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(TSizes.cardRadiusMd),
                          bottomRight: Radius.circular(
                            TSizes.productImageRadius,
                          ),
                        ),
                      ),
                      child: SizedBox(
                        width: TSizes.iconLg * 1.2,
                        height: TSizes.iconLg * 1.2,
                        child: Center(
                          child: Icon(
                            productQuantityInCart > 0
                                ? Iconsax.shopping_cart5
                                : Iconsax.add,
                            color: TColors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
