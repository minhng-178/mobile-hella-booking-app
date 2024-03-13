import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travo_app/api/api_auth.dart';

import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/helpers/image_helper.dart';
import 'package:travo_app/models/location_in_tour_model.dart';
import 'package:travo_app/providers/auth_user_provider.dart';
import 'package:travo_app/providers/dialog_provider.dart';
import 'package:travo_app/representation/screens/tour_booking_screen.dart';
import 'package:travo_app/representation/widgets/dash_line.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';
import 'package:travo_app/representation/widgets/item_utility_tour.dart';

class DetailTourScreen extends StatefulWidget {
  static const String routeName = '/detail_tour_screen';

  const DetailTourScreen({super.key, required this.tourModel});

  final LocationInTourModel tourModel;

  @override
  State<DetailTourScreen> createState() => _DetailTourScreenState();
}

class _DetailTourScreenState extends State<DetailTourScreen> {
  int? userRole;

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  Future<void> getUserRole() async {
    final ApiAuth apiAuth = ApiAuth();
    userRole = await apiAuth.getUserRole();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthUserProvider>(context);
    final isLoggedIn = userProvider.isLoggedIn;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
              child: ImageHelper.loadFromAsset(AssetHelper.placeholder,
                  fit: BoxFit.fill)),
          Positioned(
            top: kMediumPadding * 3,
            left: kMediumPadding,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    kDefaultPadding,
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(kItemPadding),
                child: Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: kDefaultPadding,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            top: kMediumPadding * 3,
            right: kMediumPadding,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    kDefaultPadding,
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(kItemPadding),
                child: Icon(
                  FontAwesomeIcons.solidHeart,
                  size: kDefaultPadding,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.3,
              maxChildSize: 0.8,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: kMediumPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kDefaultPadding * 2),
                      topRight: Radius.circular(kDefaultPadding * 2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: kDefaultPadding),
                        child: Container(
                          height: 5,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kItemPadding),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: kMediumPadding,
                      ),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          padding: EdgeInsets.zero,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.tourModel.tourName,
                                        style: TextStyles
                                            .defaultStyle.fontHeader.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '${widget.tourModel.price.toString()}VND',
                                      style:
                                          TextStyles.defaultStyle.fontCaption,
                                    ),
                                    Text(
                                      ' /person',
                                      style:
                                          TextStyles.defaultStyle.fontCaption,
                                    ),
                                  ],
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
                                    Text(widget.tourModel.tourType),
                                    Spacer(),
                                    Row(
                                      children: [
                                        ImageHelper.loadFromAsset(
                                          AssetHelper.icoVehicle,
                                        ),
                                        SizedBox(
                                          width: kMinPadding,
                                        ),
                                        Text(
                                          '${widget.tourModel.vehicleName} - ${widget.tourModel.vehicleCapacity}',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                DashLineWidget(),
                                SizedBox(
                                  height: kDefaultPadding,
                                ),
                                Row(
                                  children: [
                                    ImageHelper.loadFromAsset(
                                      AssetHelper.icoDuration,
                                    ),
                                    SizedBox(
                                      width: kMinPadding,
                                    ),
                                    Text('Duration'),
                                    Spacer(),
                                    Text(
                                      widget.tourModel.duration,
                                    ),
                                  ],
                                ),
                                DashLineWidget(),
                                SizedBox(
                                  height: kDefaultPadding,
                                ),
                                Text(
                                  'Infomation',
                                  style: TextStyles.defaultStyle.bold,
                                ),
                                SizedBox(
                                  height: kDefaultPadding,
                                ),
                                Text(
                                  widget.tourModel.description,
                                ),
                                ItemUtilityTour(),
                                SizedBox(
                                  height: kDefaultPadding,
                                ),
                                DashLineWidget(),
                                SizedBox(
                                  height: kDefaultPadding,
                                ),
                                Text(
                                  'Location: ${widget.tourModel.locationName}',
                                  style: TextStyles.defaultStyle.bold,
                                ),
                                SizedBox(
                                  height: kDefaultPadding,
                                ),
                                Text(widget.tourModel.locationAddress),
                                SizedBox(
                                  height: kDefaultPadding,
                                ),
                                ImageHelper.loadFromAsset(
                                  AssetHelper.imageMap,
                                  width: double.infinity,
                                ),
                                SizedBox(
                                  height: kMediumPadding,
                                ),
                                ItemButtonWidget(
                                    data: 'Book now',
                                    onTap: () {
                                      if (isLoggedIn == false) {
                                        Provider.of<DialogProvider>(context,
                                                listen: false)
                                            .showDialog(
                                          'error',
                                          'Error',
                                          'Please login to continue booking!',
                                          context,
                                        );
                                        return;
                                      }

                                      if (userRole != 0) {
                                        Provider.of<DialogProvider>(context,
                                                listen: false)
                                            .showDialog(
                                          'error',
                                          'Error',
                                          'Permision denied! Your account is not normal user',
                                          context,
                                        );
                                        return;
                                      }

                                      Navigator.of(context).pushNamed(
                                          TourBookingScreen.routeName,
                                          arguments: widget.tourModel);
                                    }),
                                SizedBox(
                                  height: kMediumPadding,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
