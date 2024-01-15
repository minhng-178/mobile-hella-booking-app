import 'package:flutter/material.dart';
import 'package:travo_app/core/helpers/image_helper.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/screens/hotel_booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Widget _buildItemCategory(
    Widget icon, Color color, Function() onTap, String title) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: kMediumPadding,
          ),
          decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(kItemPadding)),
          child: icon,
        ),
        SizedBox(
          height: kItemPadding,
        ),
        Text(title)
      ],
    ),
  );
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBArContainerWidget(
      titleString: 'home',
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kItemPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi James!',
                    style:
                        TextStyles.defaultStyle.fontHeader.whiteTextColor.bold),
                SizedBox(
                  height: kMediumPadding,
                ),
                Text(
                  'Where are you going next?',
                  style: TextStyles.defaultStyle.fontCaption.whiteTextColor,
                )
              ],
            ),
            Spacer(),
            Icon(
              FontAwesomeIcons.bell,
              size: kDefaultIconSize,
              color: Colors.white,
            ),
            SizedBox(
              width: kTopPadding,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kMinPadding),
                  color: Colors.white),
              padding: EdgeInsets.all(kMinPadding),
              child: ImageHelper.loadFromAsset(AssetHelper.person),
            )
          ],
        ),
      ),
      implementLeading: true,
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: 'Search your destination',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(kTopPadding),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.black,
                    size: kDefaultPadding,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(kItemPadding),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: kItemPadding)),
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Row(
            children: [
              Expanded(
                child: _buildItemCategory(
                    ImageHelper.loadFromAsset(AssetHelper.icoHotel,
                        width: kDefaultIconSize, height: kDefaultIconSize),
                    Color(0xffFE9C5E), () {
                  Navigator.of(context).pushNamed(HotelBookingScreen.routeName);
                }, 'Hotels'),
              ),
              SizedBox(width: kDefaultPadding),
              Expanded(
                child: _buildItemCategory(
                    ImageHelper.loadFromAsset(AssetHelper.icoPlane,
                        width: kDefaultIconSize, height: kDefaultIconSize),
                    Color(0xffF77777),
                    () {},
                    'Flights'),
              ),
              SizedBox(width: kDefaultPadding),
              Expanded(
                child: _buildItemCategory(
                    ImageHelper.loadFromAsset(AssetHelper.icoHotelPlane,
                        width: kDefaultIconSize, height: kDefaultIconSize),
                    Color(0xff3EC8BC),
                    () {},
                    'All'),
              ),
              SizedBox(
                height: kMediumPadding,
              ),
            ],
          )
        ],
      ),
    );
  }
}
