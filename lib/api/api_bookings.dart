import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:travo_app/api/api_auth.dart';
import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/models/booking_model.dart';
import 'package:travo_app/representation/screens/payment_method_screen.dart';
import 'package:travo_app/representation/services/notifi_service.dart';

class ApiBooking {
  final Dio _dio = Dio();
  final ApiAuth _apiAuth = ApiAuth();
  final String _baseUrl = baseUrl;

  Future<BookingModel?> createNewBooking(String bookingDate, double totalAmount,
      int tripId, int totalCustomer, BuildContext context) async {
    final snackBar = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    String? userId = await _apiAuth.getUserIdFromLocal();
    String? bearer = await _apiAuth.getBearer();

    var bookingData = {
      'bookingDate': bookingDate,
      'userId': userId,
      'totalAmount': totalAmount,
      'status': true,
      'tripId': tripId,
      'totalCustomer': totalCustomer
    };

    try {
      Response response = await _dio.post(
        "$_baseUrl/bookings",
        data: bookingData,
        options: Options(
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $bearer",
            "userId": userId
          },
        ),
      );

      log("${response.data}");

      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        BookingModel createdBooking = BookingModel.fromJson(data['data']);

        NotificationService().showNotification(
            title: 'Booking Success!', body: 'Just one more step to go!');

        navigator.pushNamed(PaymentMethodScreen.routeName,
            arguments: createdBooking);

        return createdBooking;
      } else {
        return null;
      }
    } catch (e) {
      log('Server error in the catch: $e');
      snackBar.showSnackBar(SnackBar(
        content: Text("Failed to create booking"),
        backgroundColor: Colors.red,
      ));
      throw Exception('Failed to create booking');
    }
  }
}
