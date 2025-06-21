
import 'package:flutter/material.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/device/device_utility.dart';

class TRatingProgressIndicator extends StatelessWidget {
  const TRatingProgressIndicator({
    super.key,
    required this.rating,
    required this.value,
  });

  final String rating;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(rating, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: TDeviceUtils.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: TColors.grey,
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation<Color>(
                TColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
