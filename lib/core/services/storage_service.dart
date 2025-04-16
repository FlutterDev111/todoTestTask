import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/data/models/user_model.dart';

class StorageService {
  late final SharedPreferences _prefs;

  // Keys
  static const String keyUser = 'user';
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyToken = 'token';

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // User Methods
  Future<bool> saveUser(UserModel user) async {
    return await _prefs.setString(keyUser, jsonEncode(user.toJson()));
  }

  UserModel? getUser() {
    final userStr = _prefs.getString(keyUser);
    if (userStr != null) {
      return UserModel.fromJson(jsonDecode(userStr));
    }
    return null;
  }

  // Session Methods
  Future<bool> saveIsLoggedIn(bool isLoggedIn) async {
    return await _prefs.setBool(keyIsLoggedIn, isLoggedIn);
  }

  bool isLoggedIn() {
    return _prefs.getBool(keyIsLoggedIn) ?? false;
  }

  // Token Methods
  Future<bool> saveToken(String token) async {
    return await _prefs.setString(keyToken, token);
  }

  String? getToken() {
    return _prefs.getString(keyToken);
  }

  // Clear all data
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
} 