import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';
import 'package:travo_app/core/extensions/date_ext.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/helpers/image_helper.dart';

import 'package:travo_app/models/payment_model.dart';
import 'package:travo_app/representation/widgets/dash_line.dart';

class ItemBookingHistory extends StatelessWidget {
  const ItemBookingHistory({super.key, required this.paymentModel});

  final PaymentModel paymentModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMediumPadding),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(bottom: kMediumPadding),
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paymentModel.tourName,
                          style: TextStyles.defaultStyle.fontHeader.bold,
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Row(
                          children: [
                            ImageHelper.loadFromAsset(
                              AssetHelper.icoTourguide,
                            ),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            Text(
                              paymentModel.tourguideName,
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
                        borderRadius: BorderRadius.circular(
                            kItemPadding), // Adjust the radius as needed
                        child: Image.network(paymentModel.tourImage)),
                  ),
                ],
              ),
            ),
            DashLineWidget(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Total Amount: \n${paymentModel.amount.toString()} VND',
                        style: TextStyles.defaultStyle.bold,
                      ),
                      SizedBox(
                        height: kMinPadding,
                      ),
                      Text(
                        'Total customer: ${paymentModel.totalCustomer}',
                        style: TextStyles.defaultStyle.fontCaption,
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                        'Booking date: ${formatDateString(paymentModel.bookingDate)}'),
                    SizedBox(
                      height: kMinPadding,
                    ),
                    Text(
                        'Payment date: ${paymentModel.paymentDate.getStartDate}'),
                  ],
                ))
              ],
            )
          ],
        ));
  }
}
