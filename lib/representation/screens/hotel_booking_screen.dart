import 'package:flutter/material.dart';
import 'package:travo_app/core/extensions/date_ext.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/representation/services/notifi_service.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';
import 'package:travo_app/representation/widgets/item_change_tourguide.dart';
import 'package:travo_app/representation/widgets/item_change_tourist.dart';
import 'package:travo_app/representation/widgets/item_options_booking.dart.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({super.key});

  static const routeName = '/hotel_booking_screen';

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  String? selectDate;
  String? selectTime;
  String? guestAndRoom;
  List<TourGuide> tourguides = [
    TourGuide(
        name: 'John Doe',
        imageUrl: 'https://example.com/images/john_doe.jpg',
        experience: '5 years',
        language: 'English, Spanish'),
    TourGuide(
        name: 'Jane Smith',
        imageUrl: 'https://example.com/images/jane_smith.jpg',
        experience: '3 years',
        language: 'English, French'),
    TourGuide(
        name: 'Bob Johnson',
        imageUrl: 'https://example.com/images/bob_johnson.jpg',
        experience: '10 years',
        language: 'English, German'),
    // Add more tour guides as needed
  ];

  @override
  Widget build(BuildContext context) {
    return AppBArContainerWidget(
      titleString: 'Hotel Booking',
      implementTraling: true,
      child: Column(
        children: [
          SizedBox(
            height: kMediumPadding * 2,
          ),
          ItemOptionsBookingWidget(
            title: 'Tour Name',
            value: 'South Korea',
            icon: AssetHelper.icoLocation,
            onTap: () {},
          ),
          ItemOptionsBookingWidget(
            title: 'Select Date',
            value: selectDate ?? 'Select date',
            icon: AssetHelper.icoCalendal,
            onTap: () async {
              final result = await showModalBottomSheet<List<DateTime?>>(
                context: context,
                builder: (BuildContext context) {
                  DateTime? rangeStartDate;
                  DateTime? rangeEndDate;
                  return Column(
                    children: [
                      SizedBox(
                        height: kMediumPadding,
                      ),
                      SfDateRangePicker(
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.range,
                        monthViewSettings:
                            DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                        selectionColor: ColorPalette.yellowColor,
                        startRangeSelectionColor: ColorPalette.yellowColor,
                        endRangeSelectionColor: ColorPalette.yellowColor,
                        rangeSelectionColor:
                            ColorPalette.yellowColor.withOpacity(0.25),
                        todayHighlightColor: ColorPalette.yellowColor,
                        toggleDaySelection: true,
                        onSelectionChanged:
                            (DateRangePickerSelectionChangedArgs args) {
                          if (args.value is PickerDateRange) {
                            rangeStartDate = args.value.startDate;
                            rangeEndDate = args.value.endDate;
                          } else {
                            rangeStartDate = null;
                            rangeEndDate = null;
                          }
                        },
                      ),
                      ItemButtonWidget(
                        data: 'Select',
                        onTap: () {
                          Navigator.of(context)
                              .pop([rangeStartDate, rangeEndDate]);
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
              if (result is List<DateTime?>) {
                setState(() {
                  selectDate =
                      '${result[0]?.getStartDate} - ${result[1]?.getEndDate}';
                });
              }
            },
          ),
          ItemOptionsBookingWidget(
            title: 'Select Time',
            value: selectTime ?? 'Select time',
            icon: AssetHelper.icoStar,
            onTap: () async {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: ColorPalette
                          .primaryColor, // Change this to your desired color.
                      colorScheme: ColorScheme.light(
                        primary: ColorPalette
                            .primaryColor, // Change this to your desired color.
                      ),
                      buttonTheme: ButtonThemeData(
                        textTheme: ButtonTextTheme.primary,
                      ),
                      dialogBackgroundColor: ColorPalette
                          .primaryColor, // Change this to your desired color.
                    ),
                    child: child!,
                  );
                },
              );
              if (pickedTime != null) {
                setState(() {
                  selectTime = pickedTime.format(context);
                });
              }
            },
          ),
          ItemOptionsBookingWidget(
            title: 'Tourist',
            value: guestAndRoom ?? 'Tourist',
            icon: AssetHelper.icoBed,
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
                        ItemChangeTourist(
                          initData: kids,
                          icon: AssetHelper.icoRoom,
                          value: 'Kids',
                          onNumberChanged: (int newNumber) {
                            kids = newNumber;
                          },
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        ItemButtonWidget(
                          data: 'Select',
                          onTap: () {
                            Navigator.of(context).pop([adults, kids]);
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
                  guestAndRoom = '${result[0]} Adults, ${result[1]} Kids';
                });
              }
            },
          ),
          ItemOptionsBookingWidget(
            title: 'Tourguide',
            value: tourguides[0].name,
            icon: AssetHelper.icoBed,
            onTap: () async {
              TourGuide selectedTourguide = tourguides[0];
              final result = await showDialog<TourGuide>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ItemChangeTourguide(
                          initData: selectedTourguide,
                          onTourguideChanged: (TourGuide newTourguide) {
                            selectedTourguide = newTourguide;
                          },
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextButton(
                          child: Text('Select'),
                          onPressed: () {
                            Navigator.of(context).pop(selectedTourguide);
                          },
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
              if (result is TourGuide) {
                setState(() {
                  tourguides[0].name = result.name;
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
              NotificationService().showNotification(
                  title: 'Booking Success!', body: 'Just one more step to go!');
            },
          ),
        ],
      ),
    );
  }
}
