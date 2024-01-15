import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/color_palatte.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';

class ItemButtonWidget extends StatelessWidget {
  const ItemButtonWidget(
      {super.key, required this.data, this.onTap, this.color});
  final String data;
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kMediumPadding),
            gradient: Gradients.defaultGradientBackground),
        alignment: Alignment.center,
        child: Text(
          data,
          style: TextStyles.defaultStyle.bold.whiteTextColor,
        ),
      ),
    );
  }
}
