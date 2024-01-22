import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/extensions/date_ext.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/representation/screens/guest_and_room_screen.dart';
import 'package:travo_app/representation/screens/select_date_screen.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_options_booking.dart.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({super.key});

  static const routeName = '/hotel_booking_screen';

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  String? selectDate;
  String? guestAndRoom;

  @override
  Widget build(BuildContext context) {
    return AppBArContainerWidget(
      titleString: 'Hotel Booking',
      child: Column(
        children: [
          SizedBox(
            height: kMediumPadding * 2,
          ),
          ItemOptionsBookingWidget(
            title: 'Destination',
            value: 'South Korea',
            icon: AssetHelper.icoLocation,
            onTap: () {},
          ),
          ItemOptionsBookingWidget(
            title: 'Select Date',
            value: selectDate ?? 'Select date',
            icon: AssetHelper.icoCalendal,
            onTap: () async {
              final result = await Navigator.of(context)
                  .pushNamed(SelectDateScreen.routeName);
              if (result is List<DateTime?>) {
                setState(
                  () {
                    selectDate =
                        '${result[0]?.getStartDate} - ${result[1]?.getEndDate}';
                  },
                );
              }
            },
          ),
          ItemOptionsBookingWidget(
            title: 'Guest and Room',
            value: guestAndRoom ?? 'Guest and Room',
            icon: AssetHelper.icoBed,
            onTap: () async {
              final result = await Navigator.of(context)
                  .pushNamed(GuestAndRoomScreen.routeName);
              if (result is List<int>) {
                setState(() {
                  guestAndRoom = '${result[0]} Guest, ${result[1]} Room';
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
