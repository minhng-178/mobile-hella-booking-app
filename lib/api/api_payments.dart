import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:travo_app/api/api_auth.dart';
import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/representation/screens/main_app.dart';
import 'package:travo_app/representation/screens/webview_payment_screen.dart';

class ApiPayment {
  final Dio _dio = Dio();
  final ApiAuth _apiAuth = ApiAuth();
  final String _baseUrl = baseUrl;

  void navigateToWebView(BuildContext context, String paymentUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebviewPaymentScreen(paymentUrl: paymentUrl),
      ),
    );
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
      Navigator.of(context).pushNamed(MainApp.routeName);
    } else {
      throw Exception('Failed to load IPN');
    }
  }
}
