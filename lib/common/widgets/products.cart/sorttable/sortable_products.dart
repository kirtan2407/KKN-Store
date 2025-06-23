
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/layout/grid_layout.dart';
import 'package:kkn_store/common/widgets/products.cart/products_card/product_vertical.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.sort),
          ),
          onChanged: (value) {},
    
          items:
              [
                    'Name',
                    'Higher Price',
                    'Lower Price',
                    'sale',
                    'Newest',
                    'Popularity',
                  ]
                  .map(
                    (option) => DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: TSizes.defaultSpace),
    
        TGridLayout(
          itemCount: 4,
          itemBuilder: (_, index) => const TProductCardVertical(),
        ),
      ],
    );
  }
}
