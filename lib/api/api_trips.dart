import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/models/trip_model.dart';
import 'package:travo_app/representation/screens/checkout_screen.dart';
import 'package:travo_app/representation/services/notifi_service.dart';

class ApiTrips {
  final Dio _dio = Dio();
  final String _baseUrl = baseUrl;

  Future<List<TripModel>> getAllTrips() async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/trips',
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        List<dynamic> trips = data['data'];

        return trips.map((trip) => TripModel.fromJson(trip)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log('Failed to load trips: $e');
      throw Exception('Oops! Something when wrong please wait...');
    }
  }

  Future<void> createNewTrip(int tourId, int totalCustomer, String startDate,
      String endDate, String tourGuideId, BuildContext context) async {
    final navigator = Navigator.of(context);
    final snackBar = ScaffoldMessenger.of(context);

    // Parse the date strings into DateTime objects
    DateTime parsedStartDate = DateFormat('dd MMM').parse(startDate);
    DateTime parsedEndDate = DateFormat('dd MMM').parse(endDate);

    // Format the DateTime objects to the desired format
    String formattedStartDate =
        DateFormat('yyyy-MM-ddTHH:mm:ss.sssZ').format(parsedStartDate);
    String formattedEndDate =
        DateFormat('yyyy-MM-ddTHH:mm:ss.sssZ').format(parsedEndDate);

    try {
      Response response = await _dio.post(
        "$_baseUrl/trips",
        data: {
          'tourId': tourId,
          'totalCustomer': totalCustomer,
          'startDate': formattedStartDate,
          'endDate': formattedEndDate,
          'tourGuideId': tourGuideId,
        },
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        log('Trip created successfully');
        NotificationService().showNotification(
            title: 'Booking Success!', body: 'Just one more step to go!');
        navigator.pushNamed(CheckOutScreen.routeName);
      } else {
        log('Failed to create trip');
        var errorResponse = json.decode(response.data);
        log('Server error: ${errorResponse['message']}');
        snackBar.showSnackBar(SnackBar(
          content: Text("Failed to create trip"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      log('Server error: $e');
      snackBar.showSnackBar(SnackBar(
        content: Text("Failed to create trip"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
