import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:travo_app/api/api_tours.dart';
import 'package:travo_app/models/test_model.dart';
import 'package:travo_app/models/tour_model.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';

class ToursScreen extends StatefulWidget {
  const ToursScreen({super.key});

  static const String routeName = '/tours_screen';

  @override
  State<ToursScreen> createState() => _ToursScreenState();
}

class _ToursScreenState extends State<ToursScreen> {
  late Future<Map<String, dynamic>> futureTours;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiTours apiTours = ApiTours();

    return AppBarContainerWidget(
        implementTraling: true,
        titleString: "Tours",
        child: FutureBuilder<List<TourModel>>(
          future: apiTours.getAllTours(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 75,
                      color: Colors.white,
                      child: Center(),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.red),
              );
            }
            // By default show a loading spinner.
            return const CircularProgressIndicator();
          },
        ));
  }
}
