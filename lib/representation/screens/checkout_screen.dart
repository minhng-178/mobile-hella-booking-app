import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:travo_app/api/api_bookings.dart';

import 'package:travo_app/api/api_tours.dart';
import 'package:travo_app/models/trip_model.dart';
import 'package:travo_app/models/tour_model.dart';
import 'package:travo_app/core/helpers/size_config.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/helpers/image_helper.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';
import 'package:travo_app/representation/widgets/item_trip_widget.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({
    super.key,
    required this.tripModel,
  });

  static const String routeName = '/checkout_screen';

  final TripModel tripModel;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  TourModel? _selectedTour;

  void _handleCreateBooking() async {
    ApiBooking apiBooking = ApiBooking();

    DateTime bookingDate = DateTime.now();
    String formatedBookingDate = bookingDate.toIso8601String();
    double totalAmount =
        (_selectedTour?.price ?? 0) * widget.tripModel.totalCustomer;

    apiBooking.createNewBooking(formatedBookingDate, totalAmount,
        widget.tripModel.id, widget.tripModel.totalCustomer, context);
  }

  @override
  void initState() {
    super.initState();
    _fetchTourDetails();
  }

  final List<String> steps = [
    'Book and Review',
    'Payment',
    'Confirm',
  ];
  int currentStep = 0;

  Future<void> _fetchTourDetails() async {
    ApiTours apiTours = ApiTours();
    try {
      final TourModel? tour =
          await apiTours.getTourById(widget.tripModel.tourId);
      setState(() {
        _selectedTour = tour;
      });
    } catch (e) {
      log('Error fetching tour details: $e');
    }
  }

  Widget _buildItemOptionsCheckout(String icon, String title, String value) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kDefaultPadding)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageHelper.loadFromAsset(
                icon,
              ),
              SizedBox(
                width: kDefaultPadding,
              ),
              Text(
                title,
                style: TextStyles.defaultStyle.bold,
              ),
            ],
          ),
          SizedBox(
            height: kMediumPadding,
          ),
          Container(
            width: SizeConfig.screenWidth * 0.5,
            decoration: BoxDecoration(
              color: ColorPalette.primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(
                40,
              ),
            ),
            padding: EdgeInsets.all(kMinPadding),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kMediumPadding),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.add,
                  ),
                ),
                SizedBox(width: kDefaultPadding),
                Text(
                  value,
                  style: TextStyles.defaultStyle.primaryTextColor.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCheckOutStep(
    int step,
    String nameStep,
    bool isEnd,
    bool isCheck,
  ) {
    return Row(
      children: [
        Container(
          width: kMediumPadding,
          height: kMediumPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kMediumPadding),
            color: isCheck ? Colors.white : Colors.white.withOpacity(0.1),
          ),
          alignment: Alignment.center,
          child: Text(
            step.toString(),
            style: TextStyles.defaultStyle.copyWith(
              color: isCheck ? null : Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: kMinPadding,
        ),
        Text(nameStep,
            style: TextStyles.defaultStyle.fontCaption.whiteTextColor),
        SizedBox(
          width: kMinPadding,
        ),
        if (!isEnd)
          SizedBox(
            width: kDefaultPadding,
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.white,
            ),
          ),
        if (!isEnd)
          SizedBox(
            width: kMinPadding,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: 'Checkout',
      implementTraling: true,
      child: Column(
        children: [
          Row(
            children: steps
                .map((e) => _buildItemCheckOutStep(
                    steps.indexOf(e) + 1,
                    e,
                    steps.indexOf(e) == steps.length - 1,
                    steps.indexOf(e) <= currentStep))
                .toList(),
          ),
          SizedBox(
            height: kMinPadding,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: kMediumPadding,
                  ),
                  ItemTripWidget(
                      tripModel: widget.tripModel, selectedTour: _selectedTour),
                  _buildItemOptionsCheckout(
                      AssetHelper.icoUser, 'Contact Details', 'Add Contact'),
                  SizedBox(
                    height: kMediumPadding,
                  ),
                  _buildItemOptionsCheckout(
                      AssetHelper.icoPromo, 'Promo Code', 'Add Promo Code'),
                  SizedBox(
                    height: kMediumPadding,
                  ),
                  ItemButtonWidget(
                    data: 'Payment',
                    onTap: () {
                      _handleCreateBooking();
                    },
                  ),
                  SizedBox(
                    height: kMediumPadding,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
