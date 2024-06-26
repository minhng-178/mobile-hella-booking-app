import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/providers/auth_user_provider.dart';
import 'package:travo_app/representation/screens/login_screen.dart';
import 'package:travo_app/representation/screens/main_app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travo_app/representation/services/notifi_service.dart';

class ApiAuth {
  final Dio _dio = Dio();
  final storage = FlutterSecureStorage();
  final String _baseUrl = baseUrl;

  Future<void> signIn(String email, String password,
      GlobalKey<FormState> formKey, BuildContext context) async {
    final userProvider = Provider.of<AuthUserProvider>(context, listen: false);
    final navigator = Navigator.of(context);
    final snackBar = ScaffoldMessenger.of(context);

    if (formKey.currentState!.validate()) {
      // If the form is valid, display a Snackbar.
      snackBar.showSnackBar(
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

        if (response.statusCode == 200) {
          log('User logged in successfully');
          NotificationService().showNotification(
              title: 'Login Success!', body: 'Glad to see you again!');

          // Store the tokens
          var jsonResponse = response.data;
          var accessToken = jsonResponse['token']['accessToken'];
          var refreshToken = jsonResponse['token']['refreshToken'];
          var userId = jsonResponse['userData']['id'];
          var userRole = jsonResponse['userData']['role'].toString();

          await storage.write(key: 'accessToken', value: accessToken);
          await storage.write(key: 'refreshToken', value: refreshToken);
          await storage.write(key: 'userId', value: userId);
          await storage.write(key: 'userRole', value: userRole);

          userProvider.isLoggedIn = refreshToken != null;

          navigator.pushReplacementNamed(MainApp.routeName);
        } else {
          log('Failed to log in user');
          // Handle failed login...
          var errorResponse = json.decode(response.data);
          log('Server error: ${errorResponse['message']}');
          snackBar.showSnackBar(
            SnackBar(
                content:
                    Text('Failed to log in user: ${errorResponse['message']}'),
                backgroundColor: Colors.red),
          );
        }
      } catch (e) {
        log('Server error: $e');
        snackBar.showSnackBar(
          SnackBar(
            content: Text('Failed to log in user!'),
            backgroundColor: Colors.red,
          ),
        );
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
    final navigator = Navigator.of(context);
    final snackBar = ScaffoldMessenger.of(context);

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
            'fullName': name,
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

        if (response.statusCode == 201) {
          log('User signed up successfully');
          NotificationService().showNotification(
              title: 'Register Success!', body: 'Welcome to our app!');
          navigator.pushReplacementNamed(LoginScreen.routeName);
        } else {
          log('Failed to sign up user');
          var errorResponse = json.decode(response.data);
          log('Server error: ${errorResponse['message']}');
          snackBar.showSnackBar(SnackBar(
            content: Text("Failed to sign up user"),
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        log('Server error: $e');
        snackBar.showSnackBar(SnackBar(
          content: Text("Failed to sign up user"),
          backgroundColor: Colors.red,
        ));
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

  Future<String?> getBearer() async {
    String? accessToken = await storage.read(key: 'accessToken');
    String? refreshToken = await storage.read(key: 'refreshToken');
    return accessToken != null && refreshToken != null
        ? '$accessToken:$refreshToken'
        : null;
  }

  Future<String?> getUserIdFromLocal() async {
    String? userId = await storage.read(key: 'userId');

    return userId;
  }

  Future<int?> getUserRole() async {
    String? userRoleStr = await storage.read(key: 'userRole');

    if (userRoleStr == null) {
      return null;
    }

    int intUserRole = int.parse(userRoleStr);
    return intUserRole;
  }

  Future<void> verifyTokenGoogle(
      String? accessToken, BuildContext context) async {
    final userProvider = Provider.of<AuthUserProvider>(context, listen: false);
    final navigator = Navigator.of(context);
    final snackBar = ScaffoldMessenger.of(context);

    try {
      Response response = await _dio.post(
        '$_baseUrl/Firebase/verifyGoogle',
        data: {'authToken': accessToken},
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('User logged in successfully');
        NotificationService().showNotification(
            title: 'Login Success!', body: 'Glad to see you again!');

        // Store the tokens
        var jsonResponse = response.data;
        var accessToken = jsonResponse['token']['accessToken'];
        var refreshToken = jsonResponse['token']['refreshToken'];
        var userId = jsonResponse['_id'];
        var userRole = jsonResponse['roleId'].toString();

        await storage.write(key: 'accessToken', value: accessToken);
        await storage.write(key: 'refreshToken', value: refreshToken);
        await storage.write(key: 'userId', value: userId);
        await storage.write(key: 'userRole', value: userRole);

        userProvider.isLoggedIn = refreshToken != null;

        navigator.pushReplacementNamed(MainApp.routeName);
      } else {
        log('Failed to log in user');
        // Handle failed login...
        var errorResponse = json.decode(response.data);
        log('Server error: ${errorResponse['message']}');
        snackBar.showSnackBar(
          SnackBar(
              content:
                  Text('Failed to log in user: ${errorResponse['message']}'),
              backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      log('$e');
      throw Exception('Invalid Google Token!');
    }
  }
}
