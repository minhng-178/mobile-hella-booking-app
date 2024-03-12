import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/models/location_model.dart';

class ApiLocations {
  final Dio _dio = Dio();
  final String _baseUrl = baseUrl;

  Future<List<LocationModel>> getAllLocations() async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/locations',
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        List<dynamic> locations = data['data'];

        return locations.map((tour) => LocationModel.fromJson(tour)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log('Failed to load locations: $e');
      throw Exception('Oops! Something when wrong please wait...');
    }
  }
}
