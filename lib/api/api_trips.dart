import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:travo_app/api/api_auth.dart';
import 'package:travo_app/api/api_tourguide.dart';
import 'package:travo_app/api/api_tours.dart';

import 'package:travo_app/models/tour_model.dart';
import 'package:travo_app/models/tourguide_model.dart';
import 'package:travo_app/models/trip_model.dart';
import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/representation/screens/checkout_screen.dart';
import 'package:travo_app/representation/services/notifi_service.dart';

class ApiTrips {
  final Dio _dio = Dio();
  final ApiAuth _apiAuth = ApiAuth();
  final String _baseUrl = baseUrl;
  final ApiTours _apiTours = ApiTours();
  final ApiTourguides _apiTourGuide = ApiTourguides();

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

  Future<List<TripModel>> getTripsWithTourAndTourguide() async {
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

        List<TourModel> tours = await _apiTours.getAllTours();
        List<TourGuideModel> tourguides =
            await _apiTourGuide.getAllTourguides();

        for (var trip in trips) {
          for (var tour in tours) {
            if (trip['tourId'] == tour.id) {
              trip['tourName'] = tour.tourName;
              trip['tourImage'] = tour.image;
              break;
            }
          }

          for (var tourguide in tourguides) {
            if (trip['tourGuideId'] == tourguide.id) {
              trip['tourguideName'] = tourguide.user.fullName;
              break;
            }
          }
        }

        return trips.map((trip) => TripModel.fromJson(trip)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log('Failed to load trips: $e');
      throw Exception('Oops! Something when wrong please wait...');
    }
  }

  Future<TripModel?> createNewTrip(
      int tourId,
      int totalCustomer,
      String startDate,
      String endDate,
      String tourGuideId,
      BuildContext context) async {
    final snackBar = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    var tripData = {
      'tourId': tourId,
      'totalCustomer': totalCustomer,
      'startDate': startDate,
      'endDate': endDate,
      'status': true,
      'tourGuideId': tourGuideId,
    };

    try {
      String? bearer = await _apiAuth.getBearer();

      Response response = await _dio.post(
        "$_baseUrl/trips",
        data: tripData,
        options: Options(
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $bearer",
          },
        ),
      );

      if (response.statusCode == 200) {
        log('Trip created successfully');

        Map<String, dynamic> data = response.data;

        TripModel createdTrip = TripModel.fromJson(data['data']);
        NotificationService().showNotification(
            title: 'Success!',
            body: 'Let take a look at your booking details.');
        navigator.pushNamed(
          CheckOutScreen.routeName,
          arguments: createdTrip,
        );
        return createdTrip;
      } else {
        var errorResponse = json.decode(response.data);
        log('Failed to create trip');
        log('Server error: ${errorResponse['message']}');
        snackBar.showSnackBar(SnackBar(
          content: Text("Failed to create trip"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      log('Server error in the catch: $e');
      snackBar.showSnackBar(SnackBar(
        content: Text("Failed to create trip"),
        backgroundColor: Colors.red,
      ));
    }

    return null;
  }
}
