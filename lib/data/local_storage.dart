import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _username = 'username';
  static const String _userImage = 'userImage';
  static const String _userposition = 'userposition';
  // ignore: constant_identifier_names
  static const String _userno_of_task = 'userno_of_task';
  static const String _userpercentage = 'userpercentage';

  static const String _isLoggedInKey = 'is_logged_in';

  /// Save the token
  Future<void> saveToken(String token, String username, String userImage,
      String userPosition, String userno, String userPercentage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_username, username);
    await prefs.setString(_userImage, userImage);
    await prefs.setString( _userposition, userPosition);
    await prefs.setString( _userno_of_task, userno);
    await prefs.setString( _userpercentage, userPercentage);

    await prefs.setBool(_isLoggedInKey, true);
  }

  /// Retrieve the token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_username);
  }
  Future<String?> getImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userImage);
  }
  Future<String?> getPosition() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userposition);
  }
  Future<String?> getPercentage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userpercentage);
  }
  Future<String?> getNoTask() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userno_of_task);
  }

  /// Clear the token and login state
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  /// Check if the user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }
}
