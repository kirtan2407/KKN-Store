import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/features/personalization/screens/address/add_new_address.dart';
import 'package:kkn_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:kkn_store/features/shop/screens/Home/widgets/TRoundedContainer.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

class UserAddressSscreen extends StatelessWidget {
  const UserAddressSscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primaryColor,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: KknAppbar(
        showArrowBack: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpacing),
          child: Column(
            children: [
              TSingleAdress(selectedAddress: true),
              TSingleAdress(selectedAddress: false),
              TSingleAdress(selectedAddress: false),
              TSingleAdress(selectedAddress: false),
            ],
          ),
        ),
      ),
    );
  }
}
