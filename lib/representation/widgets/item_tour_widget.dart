import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/helpers/image_helper.dart';
import 'package:travo_app/models/tour_model.dart';

class ItemTourWidget extends StatelessWidget {
  const ItemTourWidget(
      {super.key, required this.tourModel, required this.onTap});

  final TourModel tourModel;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding),
            color: Colors.white),
        margin: EdgeInsets.only(bottom: kMediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(right: kDefaultPadding),
              child: ImageHelper.loadFromAsset(
                AssetHelper.placeholder,
                radius: BorderRadius.only(
                  topLeft: Radius.circular(kDefaultPadding),
                  bottomRight: Radius.circular(kDefaultPadding),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tourModel.tourName,
                    style: TextStyles.defaultStyle.fontHeader.bold,
                  ),
                  SizedBox(height: kDefaultPadding),
                  Row(
                    children: [
                      ImageHelper.loadFromAsset(AssetHelper.icoLocationBlank),
                      SizedBox(
                        width: kMinPadding,
                      ),
                      Text(tourModel.tourType)
                    ],
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Row(
                    children: [
                      ImageHelper.loadFromAsset(
                        AssetHelper.icoStar,
                      ),
                      SizedBox(
                        width: kMinPadding,
                      ),
                      Text(
                        tourModel.price.toString(),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
