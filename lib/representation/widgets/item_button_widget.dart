import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/color_palatte.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.title, this.onTap})
      : super(key: key);
  final String title;
  final Function()? onTap;

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
          title,
          style: TextStyles.defaultStyle.bold.whiteTextColor,
        ),
      ),
    );
  }
}
