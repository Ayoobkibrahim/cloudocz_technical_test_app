import 'dart:convert';

import 'package:cloudocz_technical_test_app/features/authentication/model/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://erpbeta.cloudocz.com/api/auth/login";

  Future<UserModel?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json", // Ensure this is added
        },
        body: jsonEncode({
          "email": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return userModelFromJson(response.body);
      } else if (response.statusCode == 401) {
        throw Exception(response.body);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
