import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/models/test_model.dart';
import 'package:travo_app/models/tour_model.dart';

class ApiTours {
  final Dio _dio = Dio();
  final String _baseUrl = baseUrl;

  Future<List<TourModel>> getAllTours() async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/tours',
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );

      print('Response data: ${response.data}');

      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        List<dynamic> tours = data['data'];

        return tours.map((tour) => TourModel.fromJson(tour)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load tours: $e');
    }
  }

  Future<List<Data>> fetchData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Data.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
