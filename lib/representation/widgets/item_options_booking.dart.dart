import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';
import 'package:travo_app/core/helpers/image_helper.dart';

class ItemOptionsBookingWidget extends StatelessWidget {
  const ItemOptionsBookingWidget(
      {super.key,
      required this.title,
      required this.value,
      required this.icon,
      this.onTap});

  final String title;
  final String value;
  final String icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kTopPadding),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(bottom: kMediumPadding),
        child: Row(
          children: [
            ImageHelper.loadFromAsset(icon),
            SizedBox(
              width: kDefaultPadding,
            ),
            SizedBox(
              width: kDefaultPadding,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.defaultStyle.fontCaption,
                ),
                SizedBox(
                  height: kMinPadding,
                ),
                Text(
                  value,
                  style: TextStyles.defaultStyle.bold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
