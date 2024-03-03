import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travo_app/core/extensions/date_ext.dart';

import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/helpers/generate_end_date.dart';
import 'package:travo_app/models/location_in_tour_model.dart';
import 'package:travo_app/models/tourguide_model.dart';
import 'package:travo_app/providers/dialog_provider.dart';
import 'package:travo_app/representation/screens/checkout_screen.dart';
import 'package:travo_app/representation/services/notifi_service.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';
import 'package:travo_app/representation/widgets/item_change_guide.dart';
import 'package:travo_app/representation/widgets/item_change_tourist.dart';
import 'package:travo_app/representation/widgets/item_options_booking.dart.dart';

class TourBookingScreen extends StatefulWidget {
  const TourBookingScreen({super.key, required this.tourModel});

  static const routeName = '/tour_booking_screen';

  final LocationInTourModel tourModel;

  @override
  State<TourBookingScreen> createState() => _TourBookingScreenState();
}

class _TourBookingScreenState extends State<TourBookingScreen> {
  String? selectDate;
  String? totalCustomer;
  TourGuideModel? selectedGuide;

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: 'Tour Booking',
      implementTraling: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: kMediumPadding * 2,
            ),
            ItemOptionsBookingWidget(
              title: 'Tour Name',
              value: widget.tourModel.tourName,
              icon: AssetHelper.icoLocation,
              onTap: () {},
            ),
            ItemOptionsBookingWidget(
              title: 'Select Date',
              value: selectDate ?? 'Select date',
              icon: AssetHelper.icoCalendal,
              onTap: () async {
                final result = await showModalBottomSheet<DateTime?>(
                  context: context,
                  builder: (BuildContext context) {
                    DateTime? selectedDate;
                    return Column(
                      children: [
                        SizedBox(
                          height: kMediumPadding,
                        ),
                        SfDateRangePicker(
                          view: DateRangePickerView.month,
                          selectionMode: DateRangePickerSelectionMode
                              .single, // Change this line
                          monthViewSettings: DateRangePickerMonthViewSettings(
                              firstDayOfWeek: 1),
                          selectionColor: ColorPalette.yellowColor,
                          todayHighlightColor: ColorPalette.yellowColor,
                          toggleDaySelection: true,
                          onSelectionChanged:
                              (DateRangePickerSelectionChangedArgs args) {
                            if (args.value is DateTime) {
                              selectedDate = args.value;
                            } else {
                              selectedDate = null;
                            }
                          },
                        ),
                        ItemButtonWidget(
                          data: 'Select',
                          onTap: () {
                            if (selectedDate == null) {
                              Provider.of<DialogProvider>(context,
                                      listen: false)
                                  .showDialog(
                                'error',
                                'Error',
                                'Please select a date.',
                                context,
                              );
                            } else if (selectedDate!.isBefore(DateTime.now())) {
                              Provider.of<DialogProvider>(context,
                                      listen: false)
                                  .showDialog(
                                'error',
                                'Error',
                                'The selected date cannot be today or a past date.',
                                context,
                              );
                            } else {
                              Navigator.of(context).pop(selectedDate);
                            }
                          },
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        ItemButtonWidget(
                          data: 'Cancel',
                          color: ColorPalette.primaryColor.withOpacity(0.1),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                if (result is DateTime) {
                  setState(() {
                    selectDate = result.getStartDate;
                    DateTime endDate = calculateEndDate(
                        result,
                        widget.tourModel
                            .duration); // Replace with actual duration
                    print('End Date: $endDate');
                  });
                }
              },
            ),
            ItemOptionsBookingWidget(
              title: 'Tourist',
              value: totalCustomer ?? 'Tourist',
              icon: AssetHelper.icoCustomers,
              onTap: () async {
                int adults = 1;
                int kids = 1;
                final result = await showDialog<List<int>>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: ColorPalette.backgroundScaffoldColor,
                      surfaceTintColor: Colors.transparent,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ItemChangeTourist(
                            initData: adults,
                            icon: AssetHelper.icoGuest,
                            value: 'Adults',
                            onNumberChanged: (int newNumber) {
                              adults = newNumber;
                            },
                          ),
                          // ItemChangeTourist(
                          //   initData: kids,
                          //   icon: AssetHelper.icoRoom,
                          //   value: 'Kids',
                          //   onNumberChanged: (int newNumber) {
                          //     kids = newNumber;
                          //   },
                          // ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          ItemButtonWidget(
                            data: 'Select',
                            onTap: () {
                              Navigator.of(context).pop([adults]);
                            },
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          ItemButtonWidget(
                            data: 'Cancel',
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
                if (result is List<int>) {
                  setState(() {
                    adults = result[0];
                    kids = result[1];
                    totalCustomer = '${result[0]} Adults';
                  });
                }
              },
            ),
            ItemOptionsBookingWidget(
              title: 'Tour Guide',
              value: selectedGuide?.name ?? 'Select a guide',
              icon: AssetHelper.icoTourguide,
              onTap: () async {
                final result = await showDialog<TourGuideModel>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: ColorPalette.backgroundScaffoldColor,
                      surfaceTintColor: Colors.transparent,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ItemChangeGuide(
                            guide: TourGuideModel(
                              name: 'John Doe',
                              avatarUrl:
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNUKbV4ZCrVOwTMkfnN10Mfhwp7BSiVb64BzDuE_lA9w&s',
                              languages: ['English', 'Spanish'],
                            ),
                            onSelected: (TourGuideModel selectedGuide) {
                              Navigator.of(context).pop(selectedGuide);
                            },
                          ),
                          ItemChangeGuide(
                            guide: TourGuideModel(
                              name: 'Jane Smith',
                              avatarUrl:
                                  'https://avatar.iran.liara.run/public/92',
                              languages: ['English', 'French', 'German'],
                            ),
                            onSelected: (TourGuideModel selectedGuide) {
                              Navigator.of(context).pop(selectedGuide);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
                if (result is TourGuideModel) {
                  setState(() {
                    selectedGuide = result;
                  });
                }
              },
            ),
            SizedBox(
              width: 15,
            ),
            ItemButtonWidget(
              data: 'Submit',
              onTap: () {
                if (totalCustomer == null) {
                  Provider.of<DialogProvider>(context, listen: false)
                      .showDialog(
                    'error',
                    'Error',
                    'Please select the number of tourists before submitting.',
                    context,
                  );
                  return;
                }

                if (selectedGuide == null) {
                  Provider.of<DialogProvider>(context, listen: false)
                      .showDialog(
                    'error',
                    'Error',
                    'Please select a tour guide before submitting.',
                    context,
                  );
                  return;
                }

                NotificationService().showNotification(
                    title: 'Booking Success!',
                    body: 'Just one more step to go!');

                Navigator.of(context).pushNamed(CheckOutScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
