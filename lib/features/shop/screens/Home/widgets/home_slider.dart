import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/custom_shaps/container/circular_container.dart';
import 'package:kkn_store/features/shop/controllers/home_controller.dart';
import 'package:kkn_store/features/shop/models/banner_model.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

import '../../../../../utils/constants/colors.dart';

class TPromoslider extends StatelessWidget {
  const TPromoslider({super.key, required this.banners});

  final List<BannerModel> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            enableInfiniteScroll: true,
            autoPlay: true,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: banners.map((banner) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5), // Added margin for shadow visibility
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TRoundedImage(
              imageUrl: banner.imageUrl, 
              isNetworkImage: true,
              applyImageRadius: true,
              borderRadius: TSizes.cardRadiusLg,
              onPressed: () {
                // Handle banner tap (e.g., navigate to targetScreen)
                if (banner.targetScreen.isNotEmpty) {
                  Get.toNamed(banner.targetScreen);
                }
              },
            ),
          )).toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < banners.length; i++)
                TCircularContainer(
                  width: 20,
                  height: 5,
                  margin: const EdgeInsets.only(right: 10),
                  backgroundColor:
                      controller.carouselCurrentIndex.value == i
                          ? TColors.primaryColor
                          : TColors.grey,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
