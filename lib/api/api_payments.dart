import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:travo_app/api/api_auth.dart';
import 'package:travo_app/api/api_bookings.dart';
import 'package:travo_app/models/booking_model.dart';
import 'package:travo_app/models/payment_model.dart';
import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/representation/screens/booked_screen.dart';
import 'package:travo_app/representation/screens/webview_payment_screen.dart';

class ApiPayment {
  final Dio _dio = Dio();
  final ApiAuth _apiAuth = ApiAuth();
  final String _baseUrl = baseUrl;
  final ApiBooking _apiBooking = ApiBooking();

  void navigateToWebView(BuildContext context, String paymentUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebviewPaymentScreen(paymentUrl: paymentUrl),
      ),
    );
  }

  Future<List<PaymentModel>> getPaymentHistory() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/payments',
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        List<dynamic> payments = data['data'];

        List<BookingModel> bookings = await _apiBooking.getBookingByUserId();
        List<PaymentModel> filteredPayments = [];

        for (var payment in payments) {
          for (var booking in bookings) {
            if (payment['bookingId'] == booking.id) {
              payment['bookingDate'] = booking.bookingDate;
              payment['totalCustomer'] = booking.totalCustomer;
              payment['startDate'] = booking.startDate;
              payment['endDate'] = booking.endDate;
              payment['tourName'] = booking.tourName;
              payment['tourguideName'] = booking.tourguideName;

              filteredPayments.add(PaymentModel.fromJson(payment));
              break;
            }
          }
        }

        return filteredPayments;
      } else {
        return [];
      }
    } catch (e) {
      log('$e');
      throw Exception('Failed to get payment history');
    }
  }

  Future<String> createPayment(int bookingId, String? bankCode,
      String? language, String? desc, BuildContext context) async {
    String? userId = await _apiAuth.getUserIdFromLocal();
    String? bearer = await _apiAuth.getBearer();
    var paymentData = {
      'bookingId': bookingId,
      'bankCode': bankCode,
      'language': language,
      'descript': desc
    };

    try {
      Response response = await _dio.post(
        "$_baseUrl/create_vnpayment",
        data: paymentData,
        options: Options(
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $bearer",
            "userId": userId
          },
        ),
      );

      String paymentUrl = response.data;

      navigateToWebView(context, paymentUrl);

      return paymentUrl;
    } catch (e) {
      log('Server error in the catch: $e');
      throw Exception('Failed to create payment');
    }
  }

  Future<void> returnIpn(String queryParamsString, BuildContext context) async {
    if (queryParamsString == '') {
      throw ArgumentError('The input must not be empty');
    }

    Response response = await _dio.get('$_baseUrl/vnpay_ipn',
        queryParameters: Uri.splitQueryString(queryParamsString));

    log('$response');

    if (response.statusCode == 200) {
      Navigator.of(context).pushNamed(BookedScreen.routeName);
    } else {
      throw Exception('Failed to load IPN');
    }
  }
}
