import 'dart:developer';

import 'package:cloudocz_technical_test_app/data/local_storage.dart';
import 'package:cloudocz_technical_test_app/features/authentication/model/user_model.dart';
import 'package:cloudocz_technical_test_app/features/authentication/service/auth_service.dart';
import 'package:cloudocz_technical_test_app/features/authentication/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final LocalStorageService _localStorageService = LocalStorageService();

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
          // Save token locally
          await _localStorageService.saveToken(
              response.token,
              response.name,
              response.image,
              response.position,
              response.noOfTask.toString(),
              response.percentage.toString());
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

  //
  //
  /// Logout and clear token
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getString('auth_token') != null;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _isLoggedIn = false;
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
    notifyListeners();
  }

  Future<void> logins(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    _isLoggedIn = true;
    notifyListeners();
  }
}
