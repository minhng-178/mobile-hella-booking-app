import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/models/location_activity_model.dart';

class ApiLocationsActivites {
  final Dio _dio = Dio();
  final String _baseUrl = baseUrl;

  Future<List<LocationActivityModel>> getAllLocationActivity() async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/locations/activities',
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );

      Map<String, dynamic> data = response.data;
      List<dynamic> locations = data['data'];

      return locations.map((e) => LocationActivityModel.fromJson(e)).toList();
    } catch (e) {
      log('$e');
      throw Exception('Failed to load location activity: $e');
    }
  }

  Future<List<LocationActivityModel>> getLocationActivityByLocationId(
      int locationId) async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/locations/$locationId/activities',
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List<dynamic> activities = data['data'];

        return activities
            .map((e) => LocationActivityModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        return [];
      } else {
        log('$e');
        throw Exception('Failed to load location activity: $e');
      }
    }
  }
}
