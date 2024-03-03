import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/helpers/image_helper.dart';

class ItemUtilityTour extends StatelessWidget {
  const ItemUtilityTour({super.key});

  static const List<Map<String, String>> listUtilityTour = [
    {'icon': AssetHelper.icoWifi, 'name': 'Free\nWifi'},
    {'icon': AssetHelper.icoNonRefund, 'name': 'Non-\nRefundable'},
    {'icon': AssetHelper.icoReschedule, 'name': 'Non-\nReschedulable'},
    {'icon': AssetHelper.icoBreakfast, 'name': 'Free-\nBreakfast'},
  ];

  Widget _buildItemUtilityTourWidget(
      {required String icon, required String name}) {
    return Column(
      children: [
        ImageHelper.loadFromAsset(
          icon,
        ),
        SizedBox(
          height: kTopPadding,
        ),
        Text(
          name,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: listUtilityTour
            .map(
              (e) => _buildItemUtilityTourWidget(
                  icon: e['icon']!, name: e['name']!),
            )
            .toList(),
      ),
    );
  }
}
