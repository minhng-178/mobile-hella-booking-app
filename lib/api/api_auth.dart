import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travo_app/representation/screens/home_screen.dart';
import 'package:travo_app/representation/screens/main_app.dart';
import 'package:travo_app/representation/services/notifi_service.dart';

class ApiAuth {
  final Dio _dio = Dio();
  final storage = FlutterSecureStorage();
  final String _baseUrl = "https://hella-booking.onrender.com/api/v1";

  Future<void> signIn(String email, String password,
      GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // If the form is valid, display a Snackbar.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      try {
        Response response = await _dio.post(
          '$_baseUrl/signIn',
          data: {
            'email': email,
            'password': password,
          },
          options: Options(
            headers: {
              "Content-type": "application/json",
            },
          ),
        );

        if (response.statusCode == 201) {
          log('User logged in successfully');
          NotificationService().showNotification(
              title: 'Login Success!', body: 'Glad to see you again!');

          // Store the tokens
          var jsonResponse = response.data;
          var accessToken = jsonResponse['token']['accessToken'];
          var refreshToken = jsonResponse['token']['refreshToken'];
          await storage.write(key: 'accessToken', value: accessToken);
          await storage.write(key: 'refreshToken', value: refreshToken);

          final navigator = Navigator.of(context);

          navigator.pushReplacementNamed(MainApp.routeName);
        } else {
          log('Failed to log in user');
          // Handle failed login...
          var errorResponse = json.decode(response.data);
          log('Server error: ${errorResponse['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to log in user: ${errorResponse['message']}')),
          );
        }
      } catch (e) {
        log('Server error: $e');
      }
    }
  }

  Future<void> register(
      String email,
      String name,
      String password,
      String phone,
      String? gender,
      GlobalKey<FormState> formKey,
      BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // If the form is valid, display a Snackbar.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      try {
        Response response = await _dio.post(
          '$_baseUrl/signUp',
          data: {
            'email': email,
            'name': name,
            'password': password,
            'phone': phone,
            'gender': gender,
          },
          options: Options(
            headers: {
              "Content-type": "application/json",
            },
          ),
        );

        if (response.statusCode == 200) {
          log('User signed up successfully');
          // Handle successful sign up...
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User signed up successfully')),
          );
        } else {
          log('Failed to sign up user');
          // Handle failed sign up...
          var errorResponse = json.decode(response.data);
          log('Server error: ${errorResponse['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Failed to sign up user: ${errorResponse['message']}')),
          );
        }
      } catch (e) {
        log('Server error: $e');
      }
    }
  }

  Future<void> checkTokens() async {
    String? accessToken = await storage.read(key: 'accessToken');
    String? refreshToken = await storage.read(key: 'refreshToken');

    log('Access Token: $accessToken');
    log('Refresh Token: $refreshToken');
  }

  Future<void> refreshToken() async {
    // Prepare data to send
    var refreshToken = await storage.read(key: 'refreshToken');

    Response response = await _dio.post(
      '$_baseUrl/refreshToken',
      data: {
        'refreshToken': refreshToken,
      },
      options: Options(
        headers: {
          "Content-type": "application/json",
        },
      ),
    );

    // If the refresh token is valid, we will receive a new access token
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.data);
      var newAccessToken = jsonResponse['accessToken'];
      // Save the new access token in secure storage
      await storage.write(key: 'accessToken', value: newAccessToken);
    } else {
      // Handle error...
    }
  }
}
