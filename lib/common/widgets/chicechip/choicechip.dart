import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/custom_shaps/container/circular_container.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';

// Most of the Styling is already defined in the Utils -> Themes -> ChipTheme.dart
class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunctions.getColor(text) != null;

    return ChoiceChip(
      label: isColor ? const SizedBox() : Text(text),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(
        color:
            selected
                ? TColors.white
                : (Theme.of(context).brightness == Brightness.dark
                    ? TColors.light
                    : TColors.dark),
      ),

      avatar:
          isColor
              ? TCircularContainer(
                width: 50,
                height: 50,
                backgroundColor: THelperFunctions.getColor(text)!,
              )
              : null,
      shadowColor: TColors.darkerGrey,
      labelPadding: isColor ? const EdgeInsets.all(0) : null,
      padding: isColor ? const EdgeInsets.all(0) : null,
      shape: isColor ? const CircleBorder() : null,
      backgroundColor: isColor ? THelperFunctions.getColor(text)! : null,
    );
  }
}
