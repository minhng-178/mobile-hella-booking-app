import 'package:flutter/material.dart';
import 'package:travo_app/api/api_location_in_tour.dart';

import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/models/location_in_tour_model.dart';
import 'package:travo_app/representation/screens/detail_tour_screen.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_tour_widget.dart';

class ToursScreen extends StatefulWidget {
  static const String routeName = '/tours_screen';

  const ToursScreen({super.key});

  @override
  State<ToursScreen> createState() => _ToursScreenState();
}

class _ToursScreenState extends State<ToursScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiLocationsInTours apiLocationsInTours = ApiLocationsInTours();

    return AppBarContainerWidget(
        implementTraling: true,
        titleString: "Tours",
        child: FutureBuilder<List<LocationInTourModel>>(
          future: apiLocationsInTours.getAllLocationsInTour(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: snapshot.data!
                      .map(
                        (e) => ItemTourWidget(
                          tourModel: e,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                DetailTourScreen.routeName,
                                arguments: e);
                          },
                        ),
                      )
                      .toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            // By default show a loading spinner.
            return Center(
                child: const CircularProgressIndicator(
              color: ColorPalette.primaryColor,
            ));
          },
        ));
  }
}
