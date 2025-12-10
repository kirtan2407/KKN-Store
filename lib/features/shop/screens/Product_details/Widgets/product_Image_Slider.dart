import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/features/shop/controllers/wishlist_controller.dart';
import 'package:kkn_store/features/shop/models/product_model.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shaps/curved_edgs/curved_edge_widgets.dart';
import '../../../../../common/widgets/icon/TCircular_Icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../Home/widgets/TPosterImageSet.dart';

class TProductImageSlider extends StatefulWidget {
  const TProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  State<TProductImageSlider> createState() => _TProductImageSliderState();
}

class _TProductImageSliderState extends State<TProductImageSlider> {
  late RxString selectedImage;

  @override
  void initState() {
    super.initState();
    final images = widget.product.images != null && widget.product.images!.isNotEmpty 
        ? widget.product.images! 
        : [widget.product.thumbnail];
    selectedImage = images.first.obs;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(WishlistController());
    final images = widget.product.images != null && widget.product.images!.isNotEmpty 
        ? widget.product.images! 
        : [widget.product.thumbnail];

    return TCurvedEdgeWidgets(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            // Main large image
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.all(TSizes.productImageRadius),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Obx(() => Image(
                    image: NetworkImage(selectedImage.value),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error)),
                  )),
                ),
              ),
            ),

            // Image Slider
            if (images.length > 1)
              Positioned(
                bottom: 30,
                right: 0,
                left: 10,
                child: SizedBox(
                  height: 75,
                  child: ListView.separated(
                    separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
                    itemCount: images.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => Obx(() {
                      final imageSelected = selectedImage.value == images[index];
                      return TRoundedImage(
                        width: 75,
                        backgroundColor: dark ? TColors.dark : TColors.light,
                        border: Border.all(color: imageSelected ? TColors.primaryColor : Colors.transparent),
                        padding: const EdgeInsets.all(TSizes.sm),
                        imageUrl: images[index],
                        isNetworkImage: true,
                        onPressed: () => selectedImage.value = images[index],
                      );
                    }),
                  ),
                ),
              ),

            // Appbar
            KknAppbar(
              showArrowBack: true,
              actions: [
                Obx(() {
                  final isWishlisted = controller.isWishlisted(widget.product.id);
                  return TCircularIcon(
                    dark: dark,
                    icon: isWishlisted ? Iconsax.heart5 : Iconsax.heart,
                    color: isWishlisted ? Colors.red : TColors.darkGrey,
                    onPressed: () => controller.toggleWishlist(widget.product),
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
