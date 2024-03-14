import 'package:flutter/material.dart';
import 'package:travo_app/core/extensions/date_ext.dart';

import 'package:travo_app/models/tour_model.dart';
import 'package:travo_app/models/trip_model.dart';
import 'package:travo_app/core/helpers/image_helper.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/representation/widgets/dash_line.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';
import 'package:travo_app/representation/widgets/item_utility_tour.dart';

class ItemTripWidget extends StatelessWidget {
  const ItemTripWidget({
    super.key,
    required this.tripModel,
    this.onTap,
    this.selectedTour,
  });

  final TripModel tripModel;
  final TourModel? selectedTour;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double totalAmount = (selectedTour?.price ?? 0) * tripModel.totalCustomer;

    String startDate = tripModel.startDate;
    String endDate = tripModel.endDate;

    String formattedStartDate = formatDateString(startDate);
    String formattedEndDate = formatDateString(endDate);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kMediumPadding),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: kMediumPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedTour?.tourName ?? '',
                      style: TextStyles.defaultStyle.fontHeader.bold,
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Row(
                      children: [
                        ImageHelper.loadFromAsset(
                          AssetHelper.icoLocationBlank,
                        ),
                        SizedBox(
                          width: kMinPadding,
                        ),
                        Text(
                          selectedTour?.tourType ?? '',
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kMinPadding),
                  child: Image.network(selectedTour?.image ??
                      'https://icrier.org/wp-content/uploads/2022/09/Event-Image-Not-Found.jpg'),
                ),
              ),
            ],
          ),
          ItemUtilityTour(),
          DashLineWidget(),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Total Amount: ${totalAmount.toString()} VND',
                      style: TextStyles.defaultStyle.bold,
                    ),
                    SizedBox(
                      height: kMinPadding,
                    ),
                    Text(
                      'Total customer: ${tripModel.totalCustomer}',
                      style: TextStyles.defaultStyle.fontCaption,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  '$formattedStartDate - $formattedEndDate',
                  textAlign: TextAlign.end,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
