import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';
import 'package:travo_app/representation/widgets/item_change_guest_and_room.dart';

class GuestAndRoomScreen extends StatefulWidget {
  const GuestAndRoomScreen({super.key});

  static const String routeName = '/guest_and_room_screen';

  @override
  State<GuestAndRoomScreen> createState() => _GuestAndRoomScreenState();
}

class _GuestAndRoomScreenState extends State<GuestAndRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBArContainerWidget(
      titleString: 'Add guest and room',
      paddingContent: EdgeInsets.all(kMediumPadding),
      child: Column(
        children: [
          SizedBox(
            height: kMediumPadding,
          ),
          ItemChangeGuestAndRoom(
            initData: 1,
            icon: AssetHelper.icoGuest,
            value: 'Guest',
          ),
          ItemChangeGuestAndRoom(
            initData: 1,
            icon: AssetHelper.icoRoom,
            value: 'Room',
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          ItemButtonWidget(
            data: 'Select',
            onTap: () {
              Navigator.of(context).pop();
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
          )
        ],
      ),
    );
  }
}
