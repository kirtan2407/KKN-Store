import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

import 'package:kkn_store/features/personalization/controllers/address_controller.dart';
import 'package:kkn_store/features/personalization/models/address_model.dart';
import 'package:get/get.dart';

class TSingleAdress extends StatelessWidget {
  const TSingleAdress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      
      return InkWell(
        onTap: onTap,
        child: TRoundedContainer(
          width: double.infinity,
          padding: EdgeInsets.all(TSizes.md),
          showBorder: true,
          backgroundColor:
              selectedAddress ? TColors.primaryColorback : Colors.transparent,
          borderColor:
              selectedAddress
                  ? Colors.transparent
                  : dark
                  ? TColors.darkerGrey
                  : TColors.grey,
          margin: EdgeInsets.only(bottom: TSizes.spaceBtwItems),
  
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color:
                      selectedAddress
                          ? dark
                              ? TColors.light
                              : TColors.black.withOpacity(0.6)
                          : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: TSizes.sm / 2),
                  Text(
                    address.phoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: TSizes.sm / 2),
                  Text(
                    '${address.street}, ${address.city}, ${address.state} ${address.postalCode}, ${address.country}',
                    softWrap: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
