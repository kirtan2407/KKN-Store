import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/text/reusable_heading.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

import 'package:get/get.dart';
import 'package:kkn_store/features/personalization/controllers/address_controller.dart';
import 'package:kkn_store/features/personalization/screens/address/adress.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          showActionButton: true,
          onPressed: () => Get.to(() => const UserAddressSscreen()),
        ),
        Obx(() {
          if (controller.selectedAddress.value.id.isEmpty) {
            return Text('Select Address', style: Theme.of(context).textTheme.bodyMedium);
          }
          
          final address = controller.selectedAddress.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address.name, style: TextTheme.of(context).bodyLarge),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.grey, size: 16),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Text(address.phoneNumber, style: TextTheme.of(context).bodyMedium),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Row(
                children: [
                  const Icon(Icons.location_history, color: Colors.grey, size: 16),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: Text(
                      '${address.street}, ${address.city}, ${address.state} ${address.postalCode}, ${address.country}',
                      maxLines: 2,
                      style: TextTheme.of(context).bodyMedium,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
      ],
    );
  }
}
