import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/image.text/image_text.dart';
import 'package:kkn_store/features/shop/screens/Sub_Category/sub_categories.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'image': TImages.sports, 'title': ' Sports'},
      {'image': TImages.male_clothes, 'title': 'Male_clothes'},
      {'image': TImages.female_clothes, 'title': 'Female-clothes'},
      {'image': TImages.electronics, 'title': 'Electronics'},
      {'image': TImages.shoes, 'title': ' Shoes'},
      {'image': TImages.watches, 'title': 'Watches'},
      {'image': TImages.furniture, 'title': 'Furniture'},
      {'image': TImages.books, 'title': '  Books'},
      {'image': TImages.beauty, 'title': 'Beauty'},
      {'image': TImages.grocery, 'title': 'Grocery'},
      {'image': TImages.toys, 'title': '   Toys'},
    ];

    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final category = categories[index];
          return TVerticalImageText(
            image: category['image']!,
            title: category['title']!,
            onTap: () => Get.to(() => const SubCategoriesScreen()),
          );
        },
      ),
    );
  }
}
