import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:travo_app/core/constants/api_constants.dart';
import 'package:travo_app/models/user_model.dart';

class ApiUsers {
  final Dio _dio = Dio();
  final String _baseUrl = baseUrl;

  Future<List<UserModel>> getAllUser() async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/users',
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );
      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        List<dynamic> users = data['data'];

        return users.map((user) => UserModel.fromJson(user)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log('$e');
      throw Exception('Oops! Something when wrong please wait...');
    }
  }

  Future<List<UserModel>> getUsersWithRole(int role) async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/users',
        options: Options(
          headers: {
            "Content-type": "application/json",
          },
        ),
      );
      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        List<dynamic> users = data['data'];

        // Filter the users based on the role
        List<UserModel> usersWithRole = users
            .map((user) => UserModel.fromJson(user))
            .where((user) => user.roleId == role)
            .toList();

        return usersWithRole;
      } else {
        return [];
      }
    } catch (e) {
      log('$e');
      throw Exception('Oops! Something went wrong. Please wait...');
    }
  }
}
