import 'package:dio/dio.dart';

import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/models/vehicle_model.dart';

class ApiVehicles {
  final Dio _dio = Dio();
  final String _baseUrl = baseUrl;

  Future<List<VehicleModel>> getAllVehicles() async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/vehicles',
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        List<dynamic> vehicles = data['data'];

        return vehicles.map((tour) => VehicleModel.fromJson(tour)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load tours: $e');
    }
  }
}
