import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';

class ItemHeaderLabel extends StatelessWidget {
  const ItemHeaderLabel({
    super.key,
    required this.headerText,
  });

  final String headerText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Text(
        headerText,
        style: TextStyle(
            color: ColorPalette.text1Color, fontSize: kDefaultIconSize),
      ),
    );
  }
}
