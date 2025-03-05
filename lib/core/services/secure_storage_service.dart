import 'dart:convert';
import 'dart:developer';
import 'package:event_app/features/auth/data/models/response_model/login_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String userDataKey = 'user_data';

  Future<void> saveUserData(LoginResponseModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _secureStorage.write(key: userDataKey, value: userJson);
  }

  Future<LoginResponseModel?> getUserData() async {
    final userJson = await _secureStorage.read(key: userDataKey);
    if (userJson == null) return null;

    try {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return LoginResponseModel.fromJson(userMap);
    } catch (e) {
      log('Error parsing user data: $e');
      return null;
    }
  }

  Future<bool> isUserLoggedIn() async {
    final userData = await _secureStorage.read(key: userDataKey);
    return userData != null;
  }

  Future<void> clearUserData() async {
    await _secureStorage.delete(key: userDataKey);
  }
}
