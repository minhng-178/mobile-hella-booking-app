import 'package:dio/dio.dart';
import 'package:travo_app/api/api_vehicle.dart';

import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/models/tour_model.dart';
import 'package:travo_app/models/vehicle_model.dart';

class ApiTours {
  final Dio _dio = Dio();
  final String _baseUrl = baseUrl;
  final ApiVehicles _apiVehicles = ApiVehicles();

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

      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        List<dynamic> tours = data['data'];

        List<VehicleModel> vehicles = await _apiVehicles.getAllVehicles();

        for (var tour in tours) {
          for (var vehicle in vehicles) {
            if (tour['vehicleTypeId'] == vehicle.id) {
              tour['vehicleName'] = vehicle.vehicleName;
              tour['vehicleCapacity'] = vehicle.capacity;
              break;
            }
          }
        }

        return tours.map((tour) => TourModel.fromJson(tour)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load tours: $e');
    }
  }
}