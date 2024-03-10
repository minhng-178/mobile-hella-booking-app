import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';

class ItemEmptySection extends StatelessWidget {
  const ItemEmptySection({super.key, required this.emptyImg, this.emptyMsg});

  final String emptyImg;
  final String? emptyMsg;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(emptyImg),
            height: 150.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: kMinPadding),
            child: Text(
              emptyMsg ?? '',
              style: TextStyles.defaultStyle.subTitleTextColor,
            ),
          )
        ],
      ),
    );
  }
}
