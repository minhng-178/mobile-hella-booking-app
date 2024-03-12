import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:travo_app/api/api_locations.dart';
import 'package:travo_app/api/api_tours.dart';
import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/models/location_in_tour_model.dart';
import 'package:travo_app/models/location_model.dart';
import 'package:travo_app/models/tour_model.dart';

class ApiLocationsInTours {
  final Dio _dio = Dio();
  final String _baseUrl = baseUrl;
  final ApiLocations _apiLocations = ApiLocations();
  final ApiTours _apiTours = ApiTours();

  Future<List<LocationInTourModel>> getAllLocationsInTour() async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/tours/locations',
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        List<dynamic> locationsinTours = data['data'];

        List<LocationModel> locations = await _apiLocations.getAllLocations();
        List<TourModel> tours = await _apiTours.getAllTours();

        for (var locationinTour in locationsinTours) {
          for (var location in locations) {
            if (location.id == locationinTour['locationId']) {
              locationinTour['locationName'] = location.locationName;
              locationinTour['locationAddress'] = location.locationAddress;
              break;
            }
          }
          for (var tour in tours) {
            if (tour.id == locationinTour['tourId']) {
              locationinTour['tourName'] = tour.tourName;
              locationinTour['tourType'] = tour.tourType;
              locationinTour['price'] = tour.price;
              locationinTour['vehicleName'] = tour.vehicleName;
              locationinTour['vehicleCapacity'] = tour.vehicleCapacity;
              break;
            }
          }
        }

        return locationsinTours
            .map((tour) => LocationInTourModel.fromJson(tour))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      log('Failed to load locations in tours: $e');
      throw Exception('Oops! Something when wrong please wait...');
    }
  }
}
