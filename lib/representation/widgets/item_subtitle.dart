import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';

class ItemSubTitle extends StatelessWidget {
  final String subTitleText;
  const ItemSubTitle({
    super.key,
    required this.subTitleText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kMinPadding),
      child: Text(
        subTitleText,
        textAlign: TextAlign.center,
        style: TextStyles.defaultStyle.subTitleTextColor,
      ),
    );
  }
}
