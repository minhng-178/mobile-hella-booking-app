import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/models/tourguide_model.dart';

class ApiTourguides {
  final Dio _dio = Dio();
  final String _baseUrl = baseUrl;

  Future<List<TourGuideModel>> getAllTourguides() async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/tourguides',
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        List<dynamic> tourguides = data['data'];

        return tourguides
            .where((tourguide) => tourguide['userId']['status'] == true)
            .map((tourguide) => TourGuideModel.fromJson(tourguide))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      log('$e');
      throw Exception('Oops! Something when wrong please wait...');
    }
  }
}
