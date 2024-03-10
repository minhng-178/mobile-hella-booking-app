import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:travo_app/api/api_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:travo_app/core/constants/api_constants.dart';

class ApiPayment {
  final Dio _dio = Dio();
  final ApiAuth _apiAuth = ApiAuth();
  final String _baseUrl = baseUrl;

  Future<void> _launchURL(String urlString) async {
    Uri url = Uri.parse(urlString);

    print(url);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> createPayment(
      int bookingId, String? bankCode, String? language, String? desc) async {
    String? userId = await _apiAuth.getUserIdFromLocal();
    String? bearer = await _apiAuth.getBearer();
    var paymentData = {
      'bookingId': bookingId,
      'bankCode': bankCode,
      'language': language,
      'descript': desc
    };

    log('$paymentData');

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

      _launchURL(paymentUrl);
    } catch (e) {
      log('Server error in the catch: $e');
      throw Exception('Failed to create payment');
    }
  }
}
