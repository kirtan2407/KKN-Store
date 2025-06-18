import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/common/widgets/images/TCircularImages.dart';
import 'package:kkn_store/features/personalization/screens/profile/profile.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/constants/image_strings.dart';
import 'package:kkn_store/utils/constants/sizes.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.dark,
    required this.onPressed,
  });

  final bool dark;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed, // 👈 THIS enables navigation when tapped
      leading: TCircularImage(
        dark: dark,
        image: TImages.userAvatar2,
        width: 50,
        height: 50,
        padding: TSizes.xs,
        backgroundcolor: dark ? TColors.white : TColors.black,
      ),
      title: Text(
        'Kirtan Kankotiya',
        style: Theme.of(
          context,
        ).textTheme.headlineSmall!.apply(color: TColors.white),
      ),
      subtitle: Text(
        'Support@kirtan.com',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: Icon(Iconsax.edit, color: TColors.white),
      ),
    );
  }
}
