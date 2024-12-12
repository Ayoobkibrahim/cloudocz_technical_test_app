import 'dart:developer';

import 'package:cloudocz_technical_test_app/features/authentication/model/user_model.dart';
import 'package:cloudocz_technical_test_app/features/authentication/service/auth_service.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  Future<bool?> login(String username, String password) async {
    _userModel = null;
    _setLoading(true);
    try {
      final response = await _authService.login(username, password);
      if (response != null) {
        if (response.token.isNotEmpty) {
          _errorMessage = null;
          _setLoading(false);
          _userModel = response;
          log(_userModel.toString());
          return true;
        }
      } else {
        _userModel = null;

        _errorMessage = "Invalid username or password!";
        _setLoading(false);
        return false;
      }
      _setLoading(false);
    } catch (e) {
      _userModel = null;

      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
    return null;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
