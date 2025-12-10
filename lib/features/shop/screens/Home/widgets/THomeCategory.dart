import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/image.text/image_text.dart';
import 'package:kkn_store/features/shop/controllers/category_controller.dart';
import 'package:kkn_store/features/shop/screens/Sub_Category/sub_categories.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Obx(() {
      if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());

      if (controller.featuredCategories.isEmpty) {
        return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
      }

      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = controller.featuredCategories[index];
            return TVerticalImageText(
              image: category.image, // Ensure this is a valid URL or asset path
              title: category.name,
              // For now, we handle network images in TVerticalImageText or assume assets if local
              // If dynamic, we might need to check if it's http/https to use NetworkImage
              isNetworkImage: true, 
              onTap: () => Get.to(() => const SubCategoriesScreen()),
            );
          },
        ),
      );
    });
  }
}
