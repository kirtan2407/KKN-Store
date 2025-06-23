import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/custom_shaps/container/circular_container.dart';
import 'package:kkn_store/features/shop/controller/home_controller.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TPosterImageSet.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

import '../../../../../utils/constants/colors.dart';

class TPromoslider extends StatelessWidget {
  const TPromoslider({super.key, required this.banners});

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1, // Corrected key
            enableInfiniteScroll: true,
            autoPlay: true,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: banners.map((url) => TRoundedImage(imageUrl: url)).toList(),
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
