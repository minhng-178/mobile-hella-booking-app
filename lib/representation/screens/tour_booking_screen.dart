import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travo_app/core/extensions/date_ext.dart';

import 'package:travo_app/api/api_trips.dart';
import 'package:travo_app/api/api_tourguide.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/helpers/generate_end_date.dart';
import 'package:travo_app/models/location_in_tour_model.dart';
import 'package:travo_app/models/tourguide_model.dart';
import 'package:travo_app/providers/dialog_provider.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';
import 'package:travo_app/representation/widgets/item_change_guide.dart';
import 'package:travo_app/representation/widgets/item_change_tourist.dart';
import 'package:travo_app/representation/widgets/item_elevated_button.dart';
import 'package:travo_app/representation/widgets/item_options_booking.dart.dart';

class TourBookingScreen extends StatefulWidget {
  const TourBookingScreen({super.key, required this.tourModel});

  static const routeName = '/tour_booking_screen';

  final LocationInTourModel tourModel;

  @override
  State<TourBookingScreen> createState() => _TourBookingScreenState();
}

class _TourBookingScreenState extends State<TourBookingScreen> {
  String? selectStartDate;
  String? selectEndDate;
  String? totalCustomer;
  TourGuideModel? selectedGuide;

  void handleCreateTrip() async {
    ApiTrips apiTrips = ApiTrips();
    apiTrips.createNewTrip(
      widget.tourModel.id,
      int.parse(totalCustomer!),
      selectStartDate!,
      selectEndDate!,
      selectedGuide!.id,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    ApiTourguides apiTourguides = ApiTourguides();

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
              value: selectStartDate ?? 'Select date',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ItemElevatedButton(
                                title: 'Cancel',
                                variant: ButtonVariant.secondary,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            SizedBox(
                              width: kDefaultPadding,
                            ),
                            Expanded(
                              child: ItemElevatedButton(
                                variant: ButtonVariant.primary,
                                title: 'Select',
                                onPressed: () {
                                  if (selectedDate == null) {
                                    Provider.of<DialogProvider>(context,
                                            listen: false)
                                        .showDialog(
                                      'error',
                                      'Error',
                                      'Please select a date.',
                                      context,
                                    );
                                  } else if (selectedDate!
                                      .isBefore(DateTime.now())) {
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
                            )
                          ],
                        ),
                      ],
                    );
                  },
                );
                if (result is DateTime) {
                  setState(() {
                    selectStartDate = result.getStartDate;
                    DateTime endDate = calculateEndDate(
                        result,
                        widget.tourModel
                            .duration); // Replace with actual duration
                    selectEndDate = endDate.getEndDate;
                    print("$selectStartDate  - $selectEndDate");
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
                // int kids = 1;
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ItemElevatedButton(
                                  variant: ButtonVariant.secondary,
                                  title: 'Cancel',
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: kDefaultPadding,
                              ),
                              Expanded(
                                child: ItemElevatedButton(
                                  variant: ButtonVariant.primary,
                                  title: 'Select',
                                  onPressed: () {
                                    Navigator.of(context).pop([adults]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
                if (result is List<int>) {
                  setState(() {
                    adults = result[0];
                    // kids = result[1];
                    totalCustomer = '${result[0]} Adults';
                  });
                }
              },
            ),
            ItemOptionsBookingWidget(
              title: 'Tour Guide',
              value: selectedGuide?.user.fullName ?? 'Select a guide',
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
                          FutureBuilder<List<TourGuideModel>>(
                            future: apiTourguides.getAllTourguides(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SingleChildScrollView(
                                  child: Column(
                                      children: snapshot.data!
                                          .map((e) => ItemChangeGuide(
                                                tourguideModel: e,
                                                onSelected: (TourGuideModel?
                                                    selectedGuide) {
                                                  Navigator.of(context)
                                                      .pop(selectedGuide);
                                                },
                                              ))
                                          .toList()),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    snapshot.error.toString(),
                                    style: TextStyle(color: Colors.red),
                                  ),
                                );
                              }
                              // ? By default show a loading spinner.
                              return Center(
                                  child: const CircularProgressIndicator(
                                color: ColorPalette.primaryColor,
                              ));
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
